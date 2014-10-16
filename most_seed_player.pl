/* On choisit le coup qui rapporte le  plus de points*/
:-use_module(library(lists)).
:-[basic_moves].

most_seed_player(Player_field, Opponent_field,NPlayer, NOpponent,Best_Index, FinalPos):- gain_par_coup(Player_field, Opponent_field, List_Moves, 0), max_member(Max_Member, List_Moves), nth0(Best_Index, List_Moves, Max_Member), move( Best_Index, Player_field, Opponent_field,NPlayer, NOpponent, FinalPos).


gain_par_coup(_,_,_,5).
gain_par_coup( J_avant,Adv_avant, [G|Liste_G], X) :- move( X, J_avant, Adv_avant, J_apres, _,_), nth0(5, J_apres, G), X1 is X+1, gain_par_coup( J_avant,Adv_avant, Liste_G, X1). /* Appel récursif à vérifier */
gain_par_coup( J_avant,Adv_avant, [G|Liste_G], X) :- nth0(5, J_avant, G), X1 is X+1, gain_par_coup( J_avant,Adv_avant, Liste_G, X1).