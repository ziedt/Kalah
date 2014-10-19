/* Implementation of the minimax algorithm. 5 represents the depth to explore */

:-consult('basic_moves').
:- use_module(library(lists)).

/* eval(+J1, +J2, -Val) */
eval(J1,_,Val) :- nth0(5, J1, Val).  /*Silly and unrealistic evaluation function. used just for tests)*/

min(L, Min_Val, Ind) :- min_member(Min_Val, L), nth0(Ind, L, Min_Val),!. /*Returns min value and its index in list L*/
max(L, Min_Val, Ind) :- max_member(Min_Val, L), nth0(Ind, L, Min_Val),!. /*Returns max value and its index in list L*/

minimax(J1, J2, 5, Val, _ ) :- eval(J1,J2,Val), !.
minimax(J1, J2, Depth, Val, Ind) :-
	parcours(J1, J2, Depth,0, ListeVal),
	Depth_parity is mod(Depth,2),
	write(Depth), write(' '), write(ListeVal), nl,
	((Depth_parity == 0) -> (max(ListeVal, Val, Ind)); (min(ListeVal, Val, Ind))).

parcours(_, _, _, 5, []):-!. /*Explores tree in breadth*/
parcours(J1, J2, Depth, Pos, [S|H]) :-
	move2(J1, J2, Pos, Depth, S),
	Pos2 is Pos+1,
	parcours(J1, J2, Depth, Pos2, H).



/*OK = boolean value set to false if no seeds at Pos for player1*/

move2(J1, J2, Pos, Depth, S) :-
	Depth_parity is mod(Depth,2),
	((Depth_parity == 0) -> (move(Pos, J1, J2, J1_New, J2_New, _)); (move(Pos, J2, J1, J2_New, J1_New, _))),
	!,
	Depth2 is Depth+1,
	minimax(J1_New, J2_New, Depth2, S, _).

move2(_,_,_,_,-1000).




