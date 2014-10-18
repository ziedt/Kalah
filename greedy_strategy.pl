% ==============================================================================
% Greedy strategy : we play the first move found that allow us to increase our store. 
% Possibilities are explored from the first element in the list to the last one.
% ==============================================================================
greedy_strategy(_, Player_before,Opponent_before, Player_after, Opponent_after, Pos,FinalPos) :- 
	Pos is 0, 
	greedy_strategy_calcul(Pos, Player_before,Opponent_before, Player_after, Opponent_after, FinalPos).
	
greedy_strategy(_, Player_before,Opponent_before, Player_after, Opponent_after,Pos, FinalPos) :- 
	random_player(_, Player_before,Opponent_before, Player_after, Opponent_after, Pos, FinalPos).

% ==============================================================================
% greedy_strategy_calcul tries each move possible and stop when the move makes the store increase
% ==============================================================================
greedy_strategy_calcul(X, Player_before,Opponent_before, Player_after, Opponent_after, FinalPos) :- 
	nth0(5, Player_before, Score_before), 
	move( X, Player_before, Opponent_before, Player_after, Opponent_after, FinalPos), 
	nth0(5, Player_after, Score_after), 
	Score_after > Score_before.
	
greedy_strategy_calcul(X, Player_before,Opponent_before, Player_after, Opponent_after, FinalPos) :- 
	X1 is X+1, 
	X1 < 5, 
	greedy_strategy_calcul(X1, Player_before,Opponent_before, Player_after, Opponent_after, FinalPos).


