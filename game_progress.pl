:- [basic_moves].
:- [random_player].
:- [most_seed_player].
:- [human_player].
:- [end_in_store].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC
% ==============================================================================
% game_progress(Player1, Player2, Final_player, Final_opponent)
% -------------------------------------------------
% starts a game between the two players
% <Player1> and <Player2> are the two AIs names
% a <Player> must have the form of player(PlayerId, Player_field, Opponent_field,NPlayer, NOpponent,Position) where :
%         <PlayerId> is the number of the player (1 or 2)
%         <NPlayer> is the new field of the player after the move
%         <NOpponent> is the new field of the opponent after the move
%         <Position> is the starting position from which the player has moved
% <Final_player> is the final sate of the player's field
% <Final_opponent > is the final sate of the opponent's field
% ==============================================================================

game_progress(Player1, Player2,Result):- 
	new_player_field(Player_field), new_player_field(Opponent_field),  
	game_progress_private(1,Player1, Player2, Player_field, Opponent_field,_,_,Result),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIVATE
game_progress_private(PlayerId, _, _, Player_field,Opponent_field, _,_,Result) :- 
	game_over(PlayerId,Player_field, Opponent_field,Result), !.

game_progress_private(PlayerId, Player, Opponent, Player_field,Opponent_field, Final_player,Final_opponent,Result) :- 
	call(Player, Player_field, Opponent_field,NPlayer, NOpponent,Position), Position1 is Position,
		(print_progress(PlayerId,NPlayer,NOpponent,Position1), temporize,get_opponent(PlayerId,OpponentId),
		game_progress_private(OpponentId, Opponent, Player, NOpponent, NPlayer, Final_opponent, Final_player,Result)
		).

		
% ==============================================================================
% game_over is true when the opponent's field 
% ==============================================================================
game_over(PlayerId,Player, Opponent,Result) :-  (sub_list([0,0,0,0,0],Opponent); sub_list([0,0,0,0,0],Player)),
		sumlist(Player, PSeeds),
		sumlist(Opponent, OSeeds),
		(PSeeds>OSeeds -> Result=PlayerId ; get_opponent(PlayerId, Result)),
		write('THE END').
	

% ==============================================================================
% checks wether the first list is a sublist of the second (respects order)
% ==============================================================================
sub_list( [], _ ).
sub_list( [H|T1], [H|T2] ) :- sub_list( T1, T2).

% ==============================================================================
% asks the user for an input 
% ==============================================================================
temporize :- repeat, 
            write('Please enter 5'), 
            read(X), 
            (X=:=5).

% ==============================================================================
% Prints the state of the game after a move
% ==============================================================================
print_progress(PlayerId,Player_field, Opponent_field,Position) :- 
	write('---player--- ('), 
	write(PlayerId),
	write(')'),nl,
	write('moves from position '), write(Position),nl,
	print_base(6,Player_field), nl,
	print_base(6,Opponent_field).

print_base(0, _) :- !.
print_base(_, []).
print_base(N, [H|T]) :- write(H), write(' ,'), N1 is N - 1, print_base(N1, T).

