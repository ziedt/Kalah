/* On choisit le coup qui rapporte le  plus de points*/
:- use_module(library(lists)).

meilleur_coup(J_avant,Adv_avant, J_apres, Adv_apres):- gain_par_coup(J_avant, Adv_avant, L_coup, 0), max_member(Max_Member, L_coup), nth0(Index_meilleur, L_coup, Max_Member), coup( Index_meilleur, J_avant, Adv_avant, J_apres, Adv_apres).

gain_par_coup(_,_,_,5).
gain_par_coup( J_avant,Adv_avant, [G|Liste_G], X) :- coup( X, J_avant, Adv_avant, J_apres, _), nth0(5, J_apres, G), X1 is X+1, gain_par_coup( J_avant,Adv_avant, Liste_G, X1). /* Appel récursif à vérifier */
