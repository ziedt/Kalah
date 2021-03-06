:- [game_progress].


round_stats(Player1, Player2,Result):- 
	new_player_field(Player_field), new_player_field(Opponent_field),
	round_stats_private(1,Player1, Player2, Player_field, Opponent_field,_,_,Result),!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIVATE

round_stats_private(PlayerId, _, _, Player_field,Opponent_field, _,_,Result) :- 
	game_over_stats(PlayerId,Player_field, Opponent_field,Result), !.

round_stats_private(PlayerId, Player, Opponent, Player_field,Opponent_field, Final_player,Final_opponent,Result) :- 
	call(Player, PlayerId, Player_field, Opponent_field,NPlayer, NOpponent,Position, FinalPos), 	
	next_move_sleep(Position, FinalPos, PlayerId, Player, Opponent, NPlayer, NOpponent, Final_player,Final_opponent,Result).

% ==============================================================================
% next_move_sleep prints the result of the move, elects the next player depending on the position of the last seed distributed
% and sleeps before it plays the next round.
% ==============================================================================
next_move_sleep(_,5,PlayerId, Player, Opponent, Player_field, Opponent_field, Final_player,Final_opponent,Result) :-
	%print_progress(PlayerId,Player_field,Opponent_field,Position), 
	%sleep(0.2),
	round_stats_private(PlayerId, Player,  Opponent, Player_field, Opponent_field, Final_player, Final_opponent, Result).
	
next_move_sleep(_,16,PlayerId, Player, Opponent, Player_field, Opponent_field, Final_player,Final_opponent,Result) :-
	%print_progress(PlayerId,Player_field,Opponent_field,Position), 
	%sleep(0.2),
	round_stats_private(PlayerId, Player,  Opponent, Player_field, Opponent_field, Final_player, Final_opponent, Result).

next_move_sleep(_, _, PlayerId, Player, Opponent, Player_field, Opponent_field, Final_player,Final_opponent,Result) :-
	%print_progress(PlayerId,Player_field,Opponent_field,Position), 
	%sleep(0.2),
	get_opponent(PlayerId,OpponentId),
	round_stats_private(OpponentId, Opponent, Player, Opponent_field, Player_field, Final_opponent, Final_player,Result).
% ==============================================================================
% game_over is true when the opponent's field
% ==============================================================================
game_over_stats(PlayerId,Player, Opponent,Result) :-  (sub_list([0,0,0,0,0],Opponent); sub_list([0,0,0,0,0],Player)),
		sumlist(Player, PSeeds),
		sumlist(Opponent, OSeeds),
		(PSeeds>OSeeds -> Result=PlayerId ; get_opponent(PlayerId, Result)).
	