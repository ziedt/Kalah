:- use_module(library(lists)).
:- use_module(library(apply)).



/* Fonctions d'évaluation pour le minimax : eval(+J1, +J2, -Val) */
eval_simple(J1,_, Val) :- nth0(5,J1,Val). /* Simple heuristic : My Current Score */

eval_diff(J1,J2,Val) :- nth0(5, J1, Val1), nth0(5, J2, Val2), Val is Val1 - Val2.  /*Simple heuristic : My Current Score - Opponent current score  */

eval_potential(J1,J2,Val) :- nth0(5, J1, Val1),sum_potential(J2, Pot1), nth0(5, J2, Val2),sum_potential(J1,Pot2), Val is Val1 + Pot1 - Val2 - Pot2. 
 /*Adds up player's potential points and substracts opponents potential*/
 
 
eval_nbNonEmpty(J1,_,Val) :- number_of_unpickable(J1, Val), . /*Heuristic : I try to maximize Number of my houses non emptiable in order to let the opponent end and collect all remaining seeds, must return the number of houses with 0, or more than 3 seeds */


pickable_house(Nb_seeds) :- Nb_seeds<3.
exclude_pickable(In,Out) :- exclude(pickable_house,In,Out).
number_of_unpickable(L,R) :- exclude_pickable(L,Out), Length(Out, R).

/*Counts the potential seeds to pick in field R i.e. the sum of the seeds in houses with less than 3 seeds*/
not_potential_house(Nb_seeds) :- Nb_seeds>2.
exclude_nonPickable(In,Out) :- exclude(not_potential_house,In,Out).
sum_potential(J,Res)  :-  exclude_nonPickable(J,Out), sum_list(Out,Res).

 

min(LVal, LPos, Min_Val, Pos) :-
	min_member(Min_Val, LVal),
	nth0(Ind, LVal, Min_Val),
	nth0(Ind, LPos,Pos),!. /*Returns min value and its index in list L*/
max(LVal, LPos, Max_Val, Pos) :-
	max_member(Max_Val, LVal),
	nth0(Ind, LVal, Max_Val),
	nth0(Ind, LPos, Pos),!. /*Returns max value and its index in list L*/
	
	