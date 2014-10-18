
:- [round_stats].
:- [random_player].
:- [most_seed_player].
:- [greedy_strategy].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC
player(random_player,1).
player(most_seed_player,2).
player(greedy_strategy,3).

populate_db(Game_number):-
	retractall(games_db(_,_,_,_)),
	play_all(Game_number).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIVATE
export_to_csv(File):- 
	open(File, write, Stream).
	
		%write(Stream, X)),close(Stream).

play_game(_, _, 0,  0, 0, 0).	
play_game(P1, P2, Round_number, Won, Lost, Draw):-
	Nround_number is (Round_number - 1),
	play_game(P1, P2, Nround_number, Nwon, Nlost, Ndraw),
	round_stats(P1, P2,Result),
	increment_score(Result,  Nwon, Nlost, Ndraw, Won, Lost, Draw),!.

increment_score(0,Won, Lost, Draw, Won, Lost, Ndraw):- Ndraw is (Draw + 1).
increment_score(1,Won, Lost, Draw, Won, Nlost, Draw) :- Nlost is (Lost + 1).
increment_score(2, Won, Lost, Draw, Nwon, Lost, Draw) :- Nwon is (Won + 1).

play_all(Game_number):-
	forall((player(Player,Pid), player(Opponent,Oid)),
			add_game_db(Player,Pid,Opponent,Oid,Game_number)).


add_game_db(Player,Pid, Opponent,Oid,Game_number) :- write('Now Playing: '), 
				nl, write(Player), write(' VS '), write(Opponent),
				play_game(Player, Opponent, Game_number, Won, Lost, Draw),
				nl,write('Won games:'),write(Won),nl,
				write('Lost games:'),write(Lost),nl,
				write('Won games:'),write(Draw),nl,write('================='),nl,nl,
				assert(games_db(Pid, Oid,1, Won)),
				assert(games_db(Pid, Oid,2, Lost)),
				assert(games_db(Pid, Oid,0, Draw)).
