min_max_def(J_avant,Adv_avant, J_apres, Adv_apres, NbCoup) :- , coup( Index_meilleur, J_avant, Adv_avant, J_apres, Adv_apres).

min_max_def_calcul(J_avant,Adv_avant, J_apres, Adv_apres, 0, [G|Liste_G], X) :- meilleur_coup(J_avant,Adv_avant, J_apres, Adv_apres)
min_max_def_calcul(J_avant,Adv_avant, J_apres, Adv_apres, NbCoup, [G|Liste_G], X) :-

explorer_coup(_,_,_,5).
explorer_coup( J_avant,Adv_avant, [G|Liste_G], X) :- coup( X, J_avant, Adv_avant, J_apres, Adv_apres), nth0(5, J_apres, G), X1 is X+1, gain_par_coup( J_avant,Adv_avant, Liste_G, X1). /* Appel récursif à vérifier */
