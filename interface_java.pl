:- [game_progress].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NETWORK

connect(Port) :- 
   tcp_socket(Socket), 
   Adress = '127.0.0.1',
   tcp_connect(Socket,Adress:Port),
   tcp_open_socket(Socket,INs,OUTs), 
   assert(connectedReadStream(INs)), 
   assert(connectedWriteStream(OUTs)).
%Connect to the server
:- connect(54321).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC

javaInterface :- 
   connectedReadStream(IStream), read(IStream,(Player1,Player2)),
   %Launch Game with indicated Players (loopJavaInterface
   new_player_field(Player_field), new_player_field(Opponent_field),
   game_progress_private(1,Player1, Player2, Player_field, Opponent_field,_,_),!.
   
%Launch the game
:- javaInterface


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SPECIFIC PROCEDURE

% ==============================================================================
% Wait the User Validation
% ==============================================================================
temporize :-
	connectedWriteStream(OStream),
	write(OStream,'tempo'),
	nl(OStream),
	flush_output(OStream),
	connectedReadStream(IStream),
	repeat, 
	read(IStream,X), 
	(X=:=0).

% ==============================================================================
% Display the end of the game
% ==============================================================================	
end :-
	connectedWriteStream(OStream),
	write(OStream,'end'),
	nl(OStream),
	flush_output(OStream).
			
% ==============================================================================
% Prints the state of the game after a move
% ==============================================================================
print_progress(PlayerId,Player_field, Opponent_field,Position) :- 
    connectedWriteStream(OStream),
	NewPlayerId is PlayerId - 1,
	SelectedHole is Position + NewPlayerId * 6,
	write(OStream,'tab;'),
	write(OStream,SelectedHole),
	write(OStream,';'),
	print_base(6,Player_field),
	print_base(6,Opponent_field)
	nl(OStream),
	flush_output(OStream).
	
print_base(0, _, _) :- !.
print_base(_, [], _).
print_base(N, [H|T], Socket) :- write(Socket,H), write(';'), N1 is N - 1, print_base(N1, T).
