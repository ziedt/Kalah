/*Stratégie gloutonne : Le coup joué est le premier qui permet de manger des graines. Les maisons sont explorées dans le sens du jeu (1er élément du tableau) */
strategie_gloutonne( J_avant,Adv_avant, J_apres, Adv_apres) :- strategie_gloutonne_calcul(0, J_avant,Adv_avant, J_apres, Adv_apres).
strategie_gloutonne( J_avant,Adv_avant, J_apres, Adv_apres) :- strategie_alea(J_avant,Adv_avant, J_apres, Adv_apres).


strategie_gloutonne_calcul(X, J_avant,Adv_avant, J_apres, Adv_apres) :- nth1(6, J_avant, Score_avant), coup( X, J_avant, Adv_avant, J_apres, Adv_apres), nth1(6, J_apres, Score_apres), Score_apres > Score_avant.
strategie_gloutonne_calcul(X, J_avant,Adv_avant, J_apres, Adv_apres) :- X1 is X+1, X1 < 6, strategie_gloutonne_calcul(X1, J_avant,Adv_avant, J_apres, Adv_apres). /* Appel récursif à vérifier : Paramètres J_avant et J_apres ne changent pas d'un appel à un autre ici ! )*/


