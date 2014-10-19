/* Implementation of the minimax algorithm. 5 represents the depth to explore */

:-consult('basic_moves').
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

minimax(J1, J2, 3, Val, _ ) :- eval(J1,J2,Val), !.
minimax(J1, J2, Depth, Val, Ind) :-
	parcours(J1, J2, Depth,0, ListeVal, ListePos),
	Depth_parity is mod(Depth,2),
	((Depth_parity == 0) ->
	   (max(ListeVal, ListePos, Val, Ind));
	   (min(ListeVal,ListePos, Val, Ind))
	).

parcours(_, _, _, 5, [],[]):-!. /*Explores tree in breadth*/
parcours(J1, J2, Depth, Pos, [S|H],[Pos|LPos]) :-
	Depth_parity is mod(Depth,2),
	((Depth_parity == 0) ->
	        (move(Pos, J1, J2, J1_New, J2_New, _));
	        (move(Pos, J2, J1, J2_New, J1_New, _))
	),!,
	Depth2 is Depth+1,
	minimax(J1_New, J2_New, Depth2, S, _),
	Pos2 is Pos+1,
	parcours(J1, J2, Depth, Pos2, H,LPos).
parcours(J1, J2, Depth, Pos, H,LPos) :-
	Pos2 is Pos+1,
	parcours(J1, J2, Depth, Pos2, H,LPos).









