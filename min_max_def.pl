:- use_module(library(lists)).
:- consult(basic_moves).
:- consult(most_seed_player).

min_max_def(Player, Opponent_field, NPlayer,NOpponent) :- min_max_def_calcul(Player, Opponent_field, 0, List_Moves), min_member(Min_Member, List_Moves), nth0(Index_Best_Move, List_Moves, Min_Member), move( Index_Best_Move, Player, Opponent_field, NPlayer,NOpponent).

min_max_def_calcul(_,_,5,_).
min_max_def_calcul(Player, Opponent_field, Index, [G|List_G]) :- move( Index,Player, Opponent_field,NPlayer,NOpponent), most_seed_player(_,NOpponent, NPlayer, NNOpponent, NNPlayer, _),  nth0(5, NNOpponent, G), NewIndex is Index+1, min_max_def_calcul(Player, Opponent_field, NewIndex, List_G).