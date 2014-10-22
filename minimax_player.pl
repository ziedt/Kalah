/* Implementation of the minimax algorithm. 5 represents the depth to explore */

:-consult('basic_moves').
:-consult('minimax_utils').
:- use_module(library(lists)).

appel(Val,Ind) :-
   time(minimax([4,4,4,4,4,0],[4,4,4,4,4,0],0,Val,Ind)).


   	minimax_simple_player(_, Player_field, Opponent_field,NPlayer, NOpponent,Best_Index, FinalPos):- 
		minimax( Player_field, Opponent_field, 0, _, Best_Index,eval_simple),
		move(Best_Index, Player_field, Opponent_field, NPlayer, NOpponent, FinalPos).

	minimax_diff_player(_, Player_field, Opponent_field,NPlayer, NOpponent,Best_Index, FinalPos):- 
		minimax( Player_field, Opponent_field, 0, _, Best_Index,eval_diff),
		move(Best_Index, Player_field, Opponent_field, NPlayer, NOpponent, FinalPos).

	minimax_potential_player(_, Player_field, Opponent_field,NPlayer, NOpponent,Best_Index, FinalPos):- 
		minimax( Player_field, Opponent_field, 0, _, Best_Index,eval_potential),
		move(Best_Index, Player_field, Opponent_field, NPlayer, NOpponent, FinalPos).

	minimax_nbNonEmpty_player(_, Player_field, Opponent_field,NPlayer, NOpponent,Best_Index, FinalPos):- 
		minimax( Player_field, Opponent_field, 0, _, Best_Index,evalNbNonEmpty),
		move(Best_Index, Player_field, Opponent_field, NPlayer, NOpponent, FinalPos).

	minimax_totalSeeds_player(_, Player_field, Opponent_field,NPlayer, NOpponent,Best_Index, FinalPos):- 
		minimax( Player_field, Opponent_field, 0, _, Best_Index,eval_totalSeeds),
		move(Best_Index, Player_field, Opponent_field, NPlayer, NOpponent, FinalPos).


minimax(J1, J2, 5, Val, _, EvalFunc ) :- call(EvalFunc,J1,J2,Val), !.
minimax(J1, J2, Depth, Val, Ind,EvalFunc) :-
	parcours(J1, J2, Depth,0, ListeVal, ListePos,EvalFunc),
	Depth_parity is mod(Depth,2),
	((Depth_parity == 0) ->
	   (max(ListeVal, ListePos, Val, Ind));
	   (min(ListeVal,ListePos, Val, Ind))
	).

parcours(_, _, _, 5, [],[],_):-!. /*Explores tree in breadth*/
parcours(J1, J2, Depth, Pos, [S|H],[Pos|LPos],EvalFunc) :-
	Depth_parity is mod(Depth,2),
	((Depth_parity == 0) ->
	        (move(Pos, J1, J2, J1_New, J2_New, _));
	        (move(Pos, J2, J1, J2_New, J1_New, _))
	),
	Depth2 is Depth+1,
	minimax(J1_New, J2_New, Depth2, S, _,EvalFunc),
	!, /* minimax can also fail if no move is possible!! */
	Pos2 is Pos+1,
	parcours(J1, J2, Depth, Pos2, H,LPos,EvalFunc).
parcours(J1, J2, Depth, Pos, H,LPos,EvalFunc) :-
	Pos2 is Pos+1,
	parcours(J1, J2, Depth, Pos2, H,LPos,EvalFunc).









