:- use_module(library(lists)).



/* Fonctions d'évaluation pour le minimax : eval(+J1, +J2, -Val) */
eval_simple(J1,_, Val) :- nth0(5,J1,Val). /* Simple heuristic : My Current Score */
eval_diff(J1,J2,Val) :- nth0(5, J1, Val1), nth0(5, J2, Val2), Val is Val1 - Val2.  /*Simple heuristic : My Current Score - Opponent current score  */
eval_nbNonEmpty(J1,J2,Val) :- /*Heuristic : I try to maximize Number of my houses non emptiable in order to let the opponent end and collect all remaining seeds, must return the number of houses with 0, or more than 3 seeds */

min(LVal, LPos, Min_Val, Pos) :-
	min_member(Min_Val, LVal),
	nth0(Ind, LVal, Min_Val),
	nth0(Ind, LPos,Pos),!. /*Returns min value and its index in list L*/
max(LVal, LPos, Max_Val, Pos) :-
	max_member(Max_Val, LVal),
	nth0(Ind, LVal, Max_Val),
	nth0(Ind, LPos, Pos),!. /*Returns max value and its index in list L*/
	
	