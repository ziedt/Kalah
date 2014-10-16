%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% NETWORK

connect(Port) :- 
   tcp_socket(Socket), 
   Adress = '127.0.0.1',
   tcp_connect(Socket,Adress:Port),
   tcp_open_socket(Socket,INs,OUTs), 
   assert(connectedReadStream(INs)), 
   assert(connectedWriteStream(OUTs)).
%Connect to the server

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC

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
	write(OStream,PlayerId),
	write(OStream,';'),
	write(OStream,SelectedHole),
	write(OStream,';'),
	print_base(6,Player_field, OStream),
	write(OStream,';'),
	print_base(6,Opponent_field, OStream),
	nl(OStream),
	flush_output(OStream).
	
print_base(_, [], _).
print_base(1, [H|_], Socket) :- write(Socket,H), !.
print_base(N, [H|T], Socket) :- write(Socket,H), write(Socket,';'), N1 is N - 1, print_base(N1, T, Socket).
