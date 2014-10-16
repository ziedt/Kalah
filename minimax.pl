/* Implementation of the minimax algorithm. 5 represents the depth to explore */ 

:-consult('basic_moves').
:- use_module(library(lists)).

eval(J1,J2,Val) :- nth0(5, J1, Val).  /*Silly and unrealistic evaluation function. used just for tests)*/

min(L, Min_Val, Ind) :- min_member(Min_Val, L), nth0(Ind, L, Min_Val). /*Returns min value and its index in list L*/
max(L, Min_Val, Ind) :- max_member(Min_Val, L), nth0(Ind, L, Min_Val). /*Returns max value and its index in list L*/

minimax(J1, J2, 5, Val, _ ) :- eval(J1,J2,Val), !.
minimax(J1, J2, Depth, Val, Ind) :- 
	parcours(J1, J2, Depth,1, ListeVal),
	(Depth mod 2 == 1) -> (max(ListVal, Val, Ind)); (min(ListVal, Val, Ind)). 

parcours(_, _, _, 5, []). /*Explores tree in breadth*/
parcours(J1, J2, Depth, Pos, [S|H]) :- 
	move2(J1, J2, Pos, Depth, J1_New, J2_New, OK), /*OK = boolean value set to false if no seeds at Pos for player1*/
	Depth2 is Depth+1,
	minimax(J1_New, J2_New, Depth2, S, _),
	Pos2 is Pos+1,
	parcours(J1, J2, Depth, Pos2, H).
	
move2(J1, J2, Pos, Depth, J1_New, J2_New, 1) :-
	(Depth mod 2 == 1) -> (move(Pos, J1, J2, J1_New, J2_New, LH)); (move(Pos, J2, J1, J2_New, J1_New, LH)). 
