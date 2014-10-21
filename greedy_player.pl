% ==============================================================================
% Greedy strategy : we play the first move found that allow us to increase our store. 
% Possibilities are explored from the first element in the list to the last one.
% ==============================================================================
greedy_player(_, Player_before,Opponent_before, Player_after, Opponent_after, Pos,FinalPos) :- 
	Pos is 0, 
	greedy_player_calcul(Pos, Player_before,Opponent_before, Player_after, Opponent_after, FinalPos).
	
greedy_player(_, Player_before,Opponent_before, Player_after, Opponent_after,Pos, FinalPos) :- 
	random_player(_, Player_before,Opponent_before, Player_after, Opponent_after, Pos, FinalPos).

% ==============================================================================
% greedy_player_calcul tries each move possible and stop when the move makes the store increase
% ==============================================================================
greedy_player_calcul(X, Player_before,Opponent_before, Player_after, Opponent_after, FinalPos) :- 
	nth0(5, Player_before, Score_before), 
	move( X, Player_before, Opponent_before, Player_after, Opponent_after, FinalPos), 
	nth0(5, Player_after, Score_after), 
	Score_after > Score_before.
	
greedy_player_calcul(X, Player_before,Opponent_before, Player_after, Opponent_after, FinalPos) :- 
	X1 is X+1, 
	X1 < 5, 
	greedy_player_calcul(X1, Player_before,Opponent_before, Player_after, Opponent_after, FinalPos).


