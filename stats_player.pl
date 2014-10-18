
:- [round_stats].
:- [random_player].
:- [most_seed_player].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIVATE
export_to_csv(File):- 
	open(File, write, Stream),
	write(Stream ,'test'),
	close(Stream).

play_game(_, _, 0,  0, 0, 0).
	
play_game(P1, P2, Round_number, Won, Lost, Draw):-
	Nround_number is (Round_number - 1),
	play_game(P1, P2, Nround_number, Nwon, Nlost, Ndraw),
	round_stats(P1, P2,Result),
	increment_score(Result,  Nwon, Nlost, Ndraw, Won, Lost, Draw),!.
		
increment_score(0,Won, Lost, Draw, Won, Lost, Ndraw):- Ndraw is (Draw + 1).
increment_score(1,Won, Lost, Draw, Won, Nlost, Draw) :- Nlost is (Lost + 1).
increment_score(2, Won, Lost, Draw, Nwon, Lost, Draw) :- Nwon is (Won + 1).