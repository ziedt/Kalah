
replace([_|T], 0, X, [X|T]).
replace([H|T], I, X, [H|R]):- I > -1, NI is I-1, replace(T, NI, X, R), !.
replace(L, _, _, L).

/* 
* Replaces the value with index I with X.
* L: original list
* NL: modified list
*/
replace_wrapper(L,I,X,NL) :- replace(L,I,X,NL),!.

/*
* Copies the list L into R.
*/
copy(L,R) :- accCp(L,R).
accCp([],[]).
accCp([H|T1],[H|T2]) :- accCp(T1,T2).

/* 
* Distributes Seed starting from Pos in the list Field.We put a
* seed in the index Pos.
* NField is the modified list.
*/
distribute_in_field(0, _, NField,NField).
distribute_in_field(Seed, Pos, Field,NField) :- 
	nth0(Pos, Field, X),
	X1 is X+1, 
	replace_wrapper(Field,Pos,X1,Temp_field),
	NewSeed is Seed-1, 
	NewPos is Pos+1,
	distribute_in_field(NewSeed, NewPos, Temp_field, NField).

/*
* Distributes Seed starting from Pos in both lists .We put a
* seed in the index Pos.
* NPlayer and NOpponent are the modified lists.
*/
distribute(0, _,NPlayer,NOpponent,NPlayer,NOpponent).

distribute(Seed, Pos, Player_field, Opponent_field,NPlayer, NOpponent) :- 
	X is 7-Pos, 
	Seed<X,distribute_in_field(Seed, Pos, Player_field,NPlayer), 
	copy(Opponent_field,NOpponent).

distribute(Seed, Pos, Player_field, Opponent_field,NPlayer, NOpponent) :- 
	X is 12-Pos,
	Seed<X, 
	PSeed is 6-Pos, 
	OSeed is Seed-PSeed,
	distribute_in_field(PSeed, Pos, Player_field,NPlayer),
	distribute_in_field(OSeed, 0, Opponent_field,NOpponent).

distribute(Seed, Pos, Player_field, Opponent_field,NPlayer,  NOpponent) :- 
	PSeed is 6-Pos, 
	OSeed is 11-Pos-PSeed, 
	Rest is Seed-PSeed-OSeed, 
	distribute_in_field(PSeed, Pos, Player_field,Temp_player),
	distribute_in_field(OSeed, 0, Opponent_field,Temp_opponent), 
	distribute(Rest, 0,Temp_player,Temp_opponent, NPlayer, NOpponent).

/*
* wrapper for distribute
*/
distribute_wrapper(Seed, Pos, Player_field, Opponent_field,NPlayer,NOpponent) :- distribute(Seed, Pos,  Player_field, Opponent_field,NPlayer,NOpponent), !.

/*
* represents the basic move in the game
* takes Seed at Pos index and distributes them over player's and opponent's fields  
* starting from Pos+1.
*/
move(Pos,Player, Opponent_field,NPlayer,NOpponent):-
	nth0(Pos,Player,Seed), 
	PosDis is Pos+1, 
	replace_wrapper(Player,Pos, 0,Temp_player),
	distribute_wrapper(Seed,PosDis,Temp_player, Opponent_field, NPlayer, NOpponent).