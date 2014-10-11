:- consult(basic_moves).
:- consult(random_player).

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

game_progress(Player1, Player2, Final_player,Final_opponent):- 
	new_player_field(Player_field), new_player_field(Opponent_field),  
	game_progress_private(1,Player1, Player2, Player_field, Opponent_field,Final_player,Final_opponent).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIVATE


game_progress_private(_,_,_,_,_, Final_player,Final_opponent, _):- sublist([0,0,0,0,0], Final_player); sublist([0,0,0,0,0],Final_opponent).
game_progress_private(PlayerId, Player, Opponent, Player_field,Opponent_field, Final_player,Final_opponent) :- 
	call(Player, PlayerId, Player_field, Opponent_field,NPlayer, NOpponent,Position), 
	print_progress(PlayerId,NPlayer,NOpponent,Position), test_input(L),get_opponent(PlayerId,OpponentId),
	game_progress_private(OpponentId, Opponent, Player, NOpponent, NPlayer, Final_opponent, Final_player).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIVATE

% ==============================================================================
% asks the user for an input 
% ==============================================================================
test_input(L) :- repeat, 
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
	print(6,Player_field), nl,
	print(6,Opponent_field).

print(0, _) :- !.
print(_, []).
print(N, [H|T]) :- write(H), write(' ,'), N1 is N - 1, print(N1, T).