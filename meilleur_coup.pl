/* On choisit le coup qui rapporte le  plus de points*/


%Ecrire cas de base
gain_par_coup( J_avant,Adv_avant, J_apres, Adv_apres, [G|Liste_G], X) :-  coup( X, J_avant, Adv_avant, J_apres, Adv_apres), nth1(6, J_apres, G), X1 is X+1, gain_par_coup( J_apres,Adv_apres, J_encore_apres, Adv_encore_apres, Liste_G, X1). /* Appel récursif à vérifier */