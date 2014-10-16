:- [basic_moves].
:- [random_player].
:- [most_seed_player].
:- [human_player].
:- [end_in_store].
:- [min_max_def].
:- [greedy_strategy].
:- [java_player].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC

prolog_interface(Player1, Player2,Result):- 
    [interface_prolog],
	new_player_field(Player_field), new_player_field(Opponent_field),  
	game_progress_private(1,Player1, Player2, Player_field, Opponent_field,_,_,Result),!.
	
java_interface :- 
   [interface_java],
   connect(54321),
   connectedReadStream(IStream), read(IStream,(Player1,Player2)),
   %Launch Game with indicated Players (loopJavaInterface
   new_player_field(Player_field), new_player_field(Opponent_field),
   game_progress_private(1,Player1, Player2, Player_field, Opponent_field,_,_, _),!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIVATE
game_progress_private(PlayerId, _, _, Player_field,Opponent_field, _,_,Result) :- 
	game_over(PlayerId,Player_field, Opponent_field,Result), !.

game_progress_private(PlayerId, Player, Opponent, Player_field,Opponent_field, Final_player,Final_opponent,Result) :- 
	call(Player, PlayerId, Player_field, Opponent_field,NPlayer, NOpponent,Position, FinalPos), 	
	next_move(Position, FinalPos, PlayerId, Player, Opponent, NPlayer, NOpponent, Final_player,Final_opponent,Result).

% ==============================================================================
% next_move prints the result of the move, elects the next player depending on the position of the last seed distributed
% and makes it play
% ==============================================================================
next_move(Position,5,PlayerId, Player, Opponent, Player_field, Opponent_field, Final_player,Final_opponent,Result) :-
	print_progress(PlayerId,Player_field,Opponent_field,Position), 
	temporize,
	game_progress_private(PlayerId, Player,  Opponent, Player_field, Opponent_field, Final_player, Final_opponent, Result).
	
next_move(Position,16,PlayerId, Player, Opponent, Player_field, Opponent_field, Final_player,Final_opponent,Result) :-
	print_progress(PlayerId,Player_field,Opponent_field,Position), 
	temporize,
	game_progress_private(PlayerId, Player,  Opponent, Player_field, Opponent_field, Final_player, Final_opponent, Result).

next_move(Position, _, PlayerId, Player, Opponent, Player_field, Opponent_field, Final_player,Final_opponent,Result) :-
	print_progress(PlayerId,Player_field,Opponent_field,Position), 
	temporize,
	get_opponent(PlayerId,OpponentId),
	game_progress_private(OpponentId, Opponent, Player, Opponent_field, Player_field, Final_opponent, Final_player,Result).
	
% ==============================================================================
% game_over is true when the opponent's field 
% ==============================================================================
game_over(PlayerId,Player, Opponent,Result) :-  (sub_list([0,0,0,0,0],Opponent); sub_list([0,0,0,0,0],Player)),
		sumlist(Player, PSeeds),
		sumlist(Opponent, OSeeds),
		(PSeeds>OSeeds -> Result=PlayerId ; get_opponent(PlayerId, Result)),
		end.
	

% ==============================================================================
% checks wether the first list is a sublist of the second (respects order)
% ==============================================================================
sub_list( [], _ ).
sub_list( [H|T1], [H|T2] ) :- sub_list( T1, T2).