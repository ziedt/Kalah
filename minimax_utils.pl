:- use_module(library(lists)).



/* eval(+J1, +J2, -Val) */
eval(J1,_,Val) :- nth0(5, J1, Val).  /*Silly and unrealistic evaluation function. used just for tests)*/

min(LVal, LPos, Min_Val, Pos) :-
	min_member(Min_Val, LVal),
	nth0(Ind, LVal, Min_Val),
	nth0(Ind, LPos,Pos),!. /*Returns min value and its index in list L*/
max(LVal, LPos, Max_Val, Pos) :-
	max_member(Max_Val, LVal),
	nth0(Ind, LVal, Max_Val),
	nth0(Ind, LPos, Pos),!. /*Returns max value and its index in list L*/
	
	