
:-[basic_moves].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC

%TODO: should check if there are any seeds in a position before choosing it.

random_number(X) :- X is random(5).
random_player(Player_field, Opponent_field,NPlayer, NOpponent,X) :- random_number(X), move( X,Player_field, Opponent_field, NPlayer, NOpponent).
random_player(Player_field, Opponent_field,NPlayer, NOpponent,X) :- random_player(Player_field, Opponent_field,NPlayer, NOpponent,X).