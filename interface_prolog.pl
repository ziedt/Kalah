:- [game_progress].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC

% ==============================================================================
% game_progress(Player1, Player2, Result)
% -------------------------------------------------
% starts a game between the two players
% <Player1> and <Player2> are the two AIs names
% a <Player> must have the form of player(Player_field, Opponent_field,NPlayer, NOpponent,Position, FinalPos) where :
%         <NPlayer> is the new field of the player after the move
%         <NOpponent> is the new field of the opponent after the move
%         <Position> is the starting position from which the player has moved
% <Result> is the Id of the winner
% ==============================================================================

game_progress(Player1, Player2,Result):- 
	new_player_field(Player_field), new_player_field(Opponent_field),  
	game_progress_private(1,Player1, Player2, Player_field, Opponent_field,_,_,Result),!.

	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SPECIFIC PROCEDURE

% ==============================================================================
% asks the user for an input 
% ==============================================================================
temporize :- repeat, 
            write('Please enter 5'), 
            read(X), 
            (X=:=5).

% ==============================================================================
% Display the end of the game
% ==============================================================================	
end :-
	write('THE END').
			
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