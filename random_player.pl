
:- consult(basic_moves).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC
random_number(X) :- X is random(5).
random_player(PlayerId, Player_field, Opponent_field,NPlayer, NOpponent,X) :- random_number(X), move( X,Player_field, Opponent_field, NPlayer, NOpponent). 