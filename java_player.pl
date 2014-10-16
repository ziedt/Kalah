%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PUBLIC

java_player(PlayerId, Player_field, Opponent_field,NPlayer, NOpponent,X, FinalPos) :- ask_input(PlayerId, X), move(X,Player_field, Opponent_field, NPlayer, NOpponent, FinalPos). 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRIVATE

ask_input(PlayerId, X) :-
    connectedWriteStream(OStream),
	connectedReadStream(IStream),
	repeat,
	write(OStream,'human;'),
	write(OStream,PlayerId),
	nl(OStream),
	flush_output(OStream),
	read(IStream,X), 
	(X=:=0).