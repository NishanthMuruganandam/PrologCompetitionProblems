:- use_module(library(pio)).

lines([])           --> call(eos), !.
lines([Line|Lines]) --> line(Line), lines(Lines).

eos([], []).

line([])     --> ( "\n" ; call(eos) ), !.
line([L|Ls]) --> [L], line(Ls).

run:-
	phrase_from_file(lines(Ls),'in.txt'),
	print(Ls,L),
	write(L).

extract(X,R):-
	X = myClause(N,R).

extract(X,R):-
	X = myQuery(N,R1),
	R is neg(R1).

print([],[]).

print([H|T],[X1|T1]):-
	atom_codes(X1,H),
	%extract(X1,X),
	print(T,T1).
	
