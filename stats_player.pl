
:- [round_stats].
:- [random_player].
:- [most_seed_player].
:- [greedy_player].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC

% ==============================================================================
% the players that are going to face each other
% ==============================================================================
player(random_player,1).
player(most_seed_player,2).
player(greedy_player,3).

% ==============================================================================
% clears, then fills the database with <Game_number> of games between 
% each two players.
% ==============================================================================
populate_db(Game_number):-
	retractall(games_db(_,_,_,_)),
	play_all(Game_number).
% ==============================================================================
% exports the results in the database in csv format.
% ==============================================================================
export_to_csv(File):- 
	open(File, write, Stream),
	(
		forall(player(X,Y),
			(write(Stream, ',"'), write(Stream, X), write(Stream, '",,'))), write(Stream, '\r\n'),
		forall(player(X,Y),
			write(Stream, ',"Won","Lost","Draw"')), write(Stream, '\r\n'),

		forall(player(Player1,Player2),
		(
			write(Stream, '"'), write(Stream, Player1), write(Stream, '"'),
			forall(player(_,Id2),
			(
				forall(games_db(Player2,Id2,_,R),
				(
					write(Stream, ','), write(Stream, R)
				))
			)),
			write(Stream, '\r\n')
		))
	),close(Stream).

test(File):-
open(File,write,Stream),
write(Stream,'test gooood'),close(Stream).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIVATE

% ==============================================================================
% plays <Game_number> games betwwen the all the players added to the file.
% ==============================================================================
play_all(Game_number) :-
	forall((player(Player,Pid), player(Opponent,Oid)),
    add_game_db(Player,Pid,Opponent,Oid,Game_number)).

% ==============================================================================
% plays <Round_number> rounds between the players <P1> and <P2>
% <Won> numbers of the games won by <P1>
% <Lost> numbers of the games lost by <P1>
% <Draw> numbers of draws.
% ==============================================================================
play_game(_, _, 0,  0, 0, 0).	
play_game(P1, P2, Round_number, Won, Lost, Draw):-
	Nround_number is (Round_number - 1),
	play_game(P1, P2, Nround_number, Nwon, Nlost, Ndraw),
	round_stats(P1, P2,Result),
	increment_score(Result,  Nwon, Nlost, Ndraw, Won, Lost, Draw),!.

increment_score(0,Won, Lost, Draw, Won, Lost, Ndraw):- Ndraw is (Draw + 1).
increment_score(1,Won, Lost, Draw, Won, Nlost, Draw) :- Nlost is (Lost + 1).
increment_score(2, Won, Lost, Draw, Nwon, Lost, Draw) :- Nwon is (Won + 1).

% ==============================================================================
% adds <Game_number> of games between <Player> and <Opponent> to the database.
% ==============================================================================
add_game_db(Player,Pid, Opponent,Oid,Game_number) :- write('Now Playing: '), 
				nl, write(Player), write(' VS '), write(Opponent),
				play_game(Player, Opponent, Game_number, Won, Lost, Draw),
				nl,write('Won games:'),write(Won),nl,
				write('Lost games:'),write(Lost),nl,
				write('Won games:'),write(Draw),nl,write('================='),nl,nl,
				assert(games_db(Pid, Oid,1, Won)),
				assert(games_db(Pid, Oid,2, Lost)),
				assert(games_db(Pid, Oid,0, Draw)).
