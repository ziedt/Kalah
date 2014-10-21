:- use_module(library(lists)).
:- consult(basic_moves).
:- consult(most_seed_player).

minimax_def_player(_, Player, Opponent_field, NPlayer,NOpponent, Index_Best_Move, FinalPos) :- min_max_def_calcul(Player, Opponent_field, 0, List_Moves), min_member(Min_Member, List_Moves), nth0(Index_Best_Move, List_Moves, Min_Member), move( Index_Best_Move, Player, Opponent_field, NPlayer,NOpponent, FinalPos).
minimax_def_player(_, Player, Opponent_field, NPlayer,NOpponent, Index_Best_Move, FinalPos) :- most_seed_player(_, Player_field, Opponent_field,NPlayer, NOpponent,Best_Index, FinalPos).

min_max_def_calcul(_,_,5,_).
min_max_def_calcul(Player, Opponent_field, Index, [G|List_G]) :- move( Index,Player, Opponent_field,NPlayer,NOpponent, _), most_seed_player(_, NOpponent, NPlayer, NNOpponent, _, _,_),  nth0(5, NNOpponent, G), NewIndex is Index+1, min_max_def_calcul(Player, Opponent_field, NewIndex, List_G).
min_max_def_calcul(Player, Opponent_field, Index, [G|List_G]) :- G=21, NewIndex is Index+1, min_max_def_calcul(Player, Opponent_field, NewIndex, List_G).