/* Implementation of the alpha beta prunning of the minimax algorithm. 9 represents the depth to explore */

:-consult('basic_moves').
:-consult('minimax_utils').	
:- use_module(library(lists)).

appel_ab(Val,Ind) :-
  time(minimax_ab([4,4,4,4,4,0],[4,4,4,4,4,0],0,Val,Ind,-1000,1000)).

 alphabeta_player(_, Player_field, Opponent_field,NPlayer, NOpponent,Best_Index, FinalPos):- 
		minimax_ab( Player_field, Opponent_field, 0, _, Best_Index, -1000, 1000),
		move(Best_Index, Player_field, Opponent_field, NPlayer, NOpponent, FinalPos).



/*
-infinit = -1000
+infinit = 1000

alpha = the best value for max => initialisation at -infinit
beta = the best value for min => initialisation at +infinit
*/



/* minimax_ab(+PlayerList, +OpponetList, +Depth, -Val, -Ind, +Alpha, +Beta )*/

minimax_ab(J1, J2, 9, Val, _, _, _ ) :- eval(J1,J2,Val), !.
minimax_ab(J1, J2, Depth, Val, Ind, Alpha, Beta) :-
	parcours(J1, J2, Depth,0, ListeVal, ListePos, Alpha,Beta),
	Depth_parity is mod(Depth,2),
	((Depth_parity == 0) ->
	   (max(ListeVal, ListePos, Val, Ind));
	   (min(ListeVal,ListePos, Val, Ind))
	).

parcours(_, _, _, 5, [],[],_,_):-!. /*Explores tree in breadth*/
parcours(J1, J2, Depth, Pos, [S|H],[Pos|LPos],Alpha,Beta) :-
        Alpha < Beta,
	Depth_parity is mod(Depth,2),
	((Depth_parity == 0) ->
	        (move(Pos, J1, J2, J1_New, J2_New, _));
	        (move(Pos, J2, J1, J2_New, J1_New, _))
	),
	Depth2 is Depth+1,
	minimax_ab(J1_New, J2_New, Depth2, S, _,Alpha,Beta),
	!, /* minimax can also fail if no move is possible!! */
	Pos2 is Pos+1,
	((Depth_parity == 0) ->
	(
	     ((S > Alpha) ->
	     ( parcours(J1, J2, Depth, Pos2, H,LPos,S,Beta));
	     ( parcours(J1, J2, Depth, Pos2, H,LPos,Alpha,Beta))
	     )
	 );
	(        ((S < Beta) ->
		 ( parcours(J1, J2, Depth, Pos2, H,LPos,Alpha,S));
		 ( parcours(J1, J2, Depth, Pos2, H,LPos,Alpha,Beta))
		 )
	)
	).
parcours(J1, J2, Depth, Pos, H,LPos,A,B) :-
	Pos2 is Pos+1,
	parcours(J1, J2, Depth, Pos2, H,LPos,A,B).








