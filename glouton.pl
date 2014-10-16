/*Stratégie gloutonne : Le coup joué est le premier qui permet de manger des graines. Les maisons sont explorées dans le sens du jeu (1er élément du tableau) */
strategie_gloutonne( J_avant,Adv_avant, J_apres, Adv_apres, Pos,FinalPos) :- Pos is 0, strategie_gloutonne_calcul(Pos, J_avant,Adv_avant, J_apres, Adv_apres, FinalPos).
strategie_gloutonne( J_avant,Adv_avant, J_apres, Adv_apres,Pos, FinalPos) :- random_player(J_avant,Adv_avant, J_apres, Adv_apres, Pos, FinalPos).


strategie_gloutonne_calcul(X, J_avant,Adv_avant, J_apres, Adv_apres, FinalPos) :- nth0(5, J_avant, Score_avant), move( X, J_avant, Adv_avant, J_apres, Adv_apres, FinalPos), nth0(5, J_apres, Score_apres), Score_apres > Score_avant.
strategie_gloutonne_calcul(X, J_avant,Adv_avant, J_apres, Adv_apres, FinalPos) :- X1 is X+1, X1 < 5, strategie_gloutonne_calcul(X1, J_avant,Adv_avant, J_apres, Adv_apres, FinalPos). /* Appel récursif à vérifier : Paramètres J_avant et J_apres ne changent pas d'un appel à un autre ici ! )*/


