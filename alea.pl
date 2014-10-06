nombre_aleatoire(X) :- X is random(5)+1.
strategie_aleatoire(J_avant, Adv_avant, J_apres, Adv_apres) :- nombre_aleatoire(X), coup( X, J_avant, Adv_avant, J_apres, Adv_apres). 