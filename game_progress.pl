:- [basic_moves].
:- [random_player].
:- [most_seed_player].
:- [prolog_player].
:- [java_player].
:- [end_in_store_player].
:- [minimax_def_player].
:- [greedy_player].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC
% ==============================================================================
% prolog_interface(Player1, Player2, Result)
% -------------------------------------------------
% starts a game between the two players
% <Player1> and <Player2> are the two AIs names
% a <Player> must have the form of player(Player_field, Opponent_field,NPlayer, NOpponent,Position, FinalPos) where :
%         <NPlayer> is the new field of the player after the move
%         <NOpponent> is the new field of the opponent after the move
%         <Position> is the starting position from which the player has moved
% <Result> is the Id of the winner
% ==============================================================================

prolog_interface(Player1, Player2,Result):- 
    [interface_prolog],
	new_player_field(Player_field), new_player_field(Opponent_field),
    print_progress(1,Player_field,Opponent_field,-1), 
	game_progress_private(1,Player1, Player2, Player_field, Opponent_field,_,_,Result),!.
	
java_interface :- 
   [interface_java],
   connect(54321),
   connectedWriteStream(OStream),
   connectedReadStream(IStream),
   write(OStream,'start'), nl(OStream), flush_output(OStream),
   read(IStream,(Player1,Player2)),
   %Launch Game with indicated Players (loopJavaInterface
   new_player_field(Player_field), new_player_field(Opponent_field),
   print_progress(1,Player_field,Opponent_field,-1), 
   game_progress_private(1,Player1, Player2, Player_field, Opponent_field,_,_, _),!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIVATE
game_progress_private(PlayerId, _, _, Player_field,Opponent_field, _,_,Result) :- 
	game_over(PlayerId,Player_field, Opponent_field,Result), !.

game_progress_private(PlayerId, Player, Opponent, Player_field,Opponent_field, Final_player,Final_opponent,Result) :- 
	call(Player, PlayerId, Player_field, Opponent_field,NPlayer, NOpponent,Position, FinalPos), 	
	next_move(Position, FinalPos, PlayerId, Player, Opponent, NPlayer, NOpponent, Final_player,Final_opponent,Result).

% ==============================================================================
% next_move prints the result of the move, elects the next player depending on the position of the last seed distributed
% and asks the user to validate before it plays the next round
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
% game_over is true when the opponent's field is empty
% ==============================================================================
game_over(PlayerId,Player, Opponent,Result) :-  (sub_list([0,0,0,0,0],Opponent); sub_list([0,0,0,0,0],Player)),
		sumlist(Player, PSeeds),
		sumlist(Opponent, OSeeds),
		(PSeeds>OSeeds -> ResultTemp=PlayerId ; get_opponent(PlayerId, ResultTemp)),
		(PSeeds==OSeeds -> Result=0 ; Result=ResultTemp),
		end.
	

% ==============================================================================
% checks wether the first list is a sublist of the second (respects order)
% ==============================================================================
sub_list( [], _ ).
sub_list( [H|T1], [H|T2] ) :- sub_list( T1, T2).