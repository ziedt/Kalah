/* On choisit le coup qui rapporte le  plus de points*/
:-use_module(library(lists)).
:-[basic_moves].

most_seed_player(_, Player_field, Opponent_field,NPlayer, NOpponent,Best_Index, FinalPos):- gain_by_move(Player_field, Opponent_field, List_Moves, 0), max_member(Max_Member, List_Moves), nth0(Best_Index, List_Moves, Max_Member), move( Best_Index, Player_field, Opponent_field,NPlayer, NOpponent, FinalPos).


gain_by_move(_,_,_,5).
gain_by_move( J_avant,Adv_avant, [G|Liste_G], X) :- move( X, J_avant, Adv_avant, J_apres, Adv_apres,Last_hole), try_move_again(Last_hole, J_apres, Adv_apres, Gain), nth0(5, J_apres, Store), G=Store+Gain, X1 is X+1, gain_by_move( J_avant,Adv_avant, Liste_G, X1). /* Appel récursif à vérifier */
gain_by_move( J_avant,Adv_avant, [G|Liste_G], X) :- nth0(5, J_avant, G), X1 is X+1, gain_by_move( J_avant,Adv_avant, Liste_G, X1).

try_move_again(5, Player_field, Opponent_field, Gain) :- gain_by_move(Player_field, Opponent_field, List_Moves, 0), max_member(Gain, List_Moves).
try_move_again(16, Player_field, Opponent_field, Gain) :- gain_by_move(Player_field, Opponent_field, List_Moves, 0), max_member(Gain, List_Moves).
try_move_again(_, _, _, Gain) :- Gain is 0.