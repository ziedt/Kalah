/* Implementation of the minimax algorithm. 5 represents the depth to explore */

:-consult('basic_moves').
:-consult('minimax_utils').
:- use_module(library(lists)).

appel(Val,Ind) :-
   time(minimax([4,4,4,4,4,0],[4,4,4,4,4,0],0,Val,Ind)).


   minimax_player(_, Player_field, Opponent_field,NPlayer, NOpponent,Best_Index, FinalPos):- 
		minimax( Player_field, Opponent_field, 0, _, Best_Index),
		move(Best_Index, Player_field, Opponent_field, NPlayer, NOpponent, FinalPos).



minimax(J1, J2, 5, Val, _ ) :- eval_diff(J1,J2,Val), !.
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
	),
	Depth2 is Depth+1,
	minimax(J1_New, J2_New, Depth2, S, _),
	!, /* minimax can also fail if no move is possible!! */
	Pos2 is Pos+1,
	parcours(J1, J2, Depth, Pos2, H,LPos).
parcours(J1, J2, Depth, Pos, H,LPos) :-
	Pos2 is Pos+1,
	parcours(J1, J2, Depth, Pos2, H,LPos).









