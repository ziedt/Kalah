% ==============================================================================
% Random strategy : plays any position containing seeds
% ==============================================================================

random_number(X) :- X is random(5).
random_player(_, Player_field, Opponent_field,NPlayer, NOpponent,X, FinalPos) :- repeat, random_number(X), move( X,Player_field, Opponent_field, NPlayer, NOpponent, FinalPos).