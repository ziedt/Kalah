% ==============================================================================
% End in store strategy : plays the first move found that end in the player's store.
% If there isn't any, it chooses a move randomly.
% ==============================================================================

:- consult('basic_moves').
:- use_module(library(lists)).

ends_in_store(J_avant, I) :- nth0(I, J_avant, Nb_seeds),I<5 , Nb_seeds is 5-I.

list_end_in_store_player(J_avant,L) :- bagof(C, ends_in_store(J_avant,C), L).

pos_to_play(J_avant, P) :- (list_end_in_store_player(J_avant,L)) -> (max_member(P,L));(P is random(5)).

end_in_store_player(_,J_avant, Adv_avant,J_apres, Adv_apres,Pos, FinalPos) :- pos_to_play(J_avant, Pos), move(Pos, J_avant, Adv_avant, J_apres, Adv_apres, FinalPos).