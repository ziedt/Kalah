a([4,4,4,4,4,0]).
b([4,4,4,4,4,0]).




replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

doReplace(L,I,X,NL) :- replace(L,I,X,NL),!.

copy(L,R) :- accCp(L,R).
accCp([],[]).
accCp([H|T1],[H|T2]) :- accCp(T1,T2).

/* Distribue les graines à partir de la position pos (on met une graine dans pos)*/
distribuer(0, _, Y,Y).
distribuer(Seed, Pos, Joueur,Y) :- nth0(Pos, Joueur, X),X1 is X+1, doReplace(Joueur,Pos,X1,NJoueur),NewSeed is Seed-1, NewPos is Pos+1,distribuer(NewSeed, NewPos, NJoueur, Y).

doDistribuer(0, _, _, _,_, _).
doDistribuer(Seed, Pos, Joueur, Adversaire,NJ, NA) :- X is 7-Pos, Seed<X,distribuer(Seed, Pos, Joueur,NJ), copy(Adversaire,NA).

doDistribuer(Seed, Pos, Joueur, Adversaire,NJ, NA) :- X is 12-Pos,Seed<X, PSeed is 6-Pos, OSeed is Seed-PSeed, distribuer(PSeed, Pos, Joueur,NJ),distribuer(OSeed, 0, Adversaire,NA).

doDistribuer(Seed, Pos, Joueur, Adversaire,JoueurFinal, AdvFinal) :- PSeed is 6-Pos, OSeed is 11-Pos-PSeed, Reste is Seed-PSeed-OSeed, distribuer(PSeed, Pos, Joueur,NJ),distribuer(OSeed, 0, Adversaire,NA), doDistribuer(Reste, 0, NJ,NA, JoueurFinal, AdvFinal).




coup(Position, Joueur, Adversaire,Y):- nth0(Position, Joueur, X), PosDis is Position+1, doDistribuer(X, PosDis, Joueur, Adversaire, NJoueur), doReplace(NJoueur,Position, 0, Y).