
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC

test_input(X) :- repeat, 
            write('Please enter a number between 0 and 4'), 
            read(X), 
            (0=<X , X=<4).
			
human_player(PlayerId, Player_field, Opponent_field,NPlayer, NOpponent,X) :- test_input(X), move(X,Player_field, Opponent_field, NPlayer, NOpponent). 