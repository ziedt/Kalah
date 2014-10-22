:- use_module(library(lists)).
:- use_module(library(apply)).
:- consult(basic_moves).



/* Fonctions d'évaluation pour le minimax : eval(+J1, +J2, -Val) */
eval_simple(J1,_, Val) :- nth0(5,J1,Val). /* Simple heuristic : My Current Score */

eval_diff(J1,J2,Val) :- nth0(5, J1, Val1), nth0(5, J2, Val2), Val is Val1 - Val2.  /*Simple heuristic : My Current Score - Opponent current score  */

eval_potential(J1,J2,Val) :- nth0(5, J1, Val1),sum_potential(J2, Pot1), nth0(5, J2, Val2),sum_potential(J1,Pot2), Val is Val1 + Pot1 - Val2 - Pot2. 
 /*Adds up player's potential points and substracts opponents potential*/
 
 
eval_nbNonEmpty(J1,_,Val) :- number_of_unpickable(J1, Val). /*Heuristic : I try to maximize Number of my houses non emptiable in order to let the opponent end and collect all remaining seeds, must return the number of houses with 0, or more than 3 seeds */

eval_totalSeeds(J1,_,Val) :- replace(J1,5,0,Res), sum_list(Res,Val). /*Heuristic : Close to nbNonEmpty : computes number of seeds in my play ground = keep as many seeds on the players own side*/

% After testing, we affect weights to the evaluation functions depending on their result in a round-robin tournament.
eval_ultimate(J1,J2,Val) :- eval_simple(J1,_, Vals), eval_diff(J1,J2,Vald), 
							eval_potential(J1,J2,Valp), 
							eval_nbNonEmpty(J1,_,Valem), 
							eval_totalSeeds(J1,_,Valt), Val is Vald +  (Valt + Valp) * 0.5 + (Vals + Valem)* 0.25 .							



pickable_house(Nb_seeds) :- Nb_seeds < 3.
exclude_pickable(In,Out) :- exclude(pickable_house,In,Out).
number_of_unpickable(L,R) :- exclude_pickable(L,Out), length(Out,R).

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
	
