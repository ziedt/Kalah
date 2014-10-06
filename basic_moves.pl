a([4,4,4,4,4,0]).
b([4,4,4,4,4,0]).




replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

doReplace(L,I,X,NL) :- replace(L,I,X,NL),!.

/* Distribue les graines à partir de la position pos (on met une graine dans pos)*/
distribuer(0, _, Y, _,Y).
distribuer(Seed, Pos, Joueur, Adversaire,Y) :- nth0(Pos, Joueur, X),X1 is X+1, doReplace(Joueur,Pos,X1,NJoueur),NewSeed is Seed-1, NewPos is Pos+1,distribuer(NewSeed, NewPos, NJoueur, Adversaire,Y).


coup(Position, Joueur, Adversaire,Y):- nth0(Position, Joueur, X), PosDis is Position+1, distribuer(X, PosDis, Joueur, Adversaire, NJoueur), doReplace(NJoueur,Position, 0, Y).