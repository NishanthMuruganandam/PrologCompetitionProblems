:- use_module(library(lists)).
:- use_module(library(clpfd)).

r(0).
s(0).
l(2).
t(2).

unzip(_,0,[]).

unzip(E,N,[E|T]):-
	N > 0,
	N1 is N-1,
	unzip(E,N1,T).

extractPieces(Pieces):-
	r(R),
	unzip(r,R,Pieces1),
	s(S),
	unzip(s,S,Pieces2),
	l(L),
	unzip(l,L,Pieces3),
	t(T),
	unzip(t,T,Pieces4),
	append(Pieces1,Pieces2,Temp1),
	append(Pieces3,Pieces4,Temp2),
	append(Temp1,Temp2,Pieces).


threeConsecutive(R1,R2,R3,B):-
	nextto(R1,R2,B),
	nextto(R2,R3,B).

solve(_,[]).

solve(Board,Pieces):-
	select(Piece,Pieces,RemainingPieces),
	fill(Board,Piece),
	solve(Board,RemainingPieces).

solve:-
	(Board = [[_,_,_,_],
		 [_,_,_,_],
		 [_,_,_,_],
		 [_,_,_,_]],
	extractPieces(Pieces),
	solve(Board,Pieces),
	write('Yes'));
	write('No').

fill(Board,r):-
	member([A,A,A,A],Board),
	var(A),
	A = r.

fill(Board,r):-
	transpose(Board, NewBoard),
	member([A,A,A,A],NewBoard),
	var(A),
	A = r,
	transpose(NewBoard,Board).

fill(Board,s):-
	nextto([A,A,_,_],[A,A,_,_],Board),
	var(A),
	A = s.

fill(Board,s):-
	nextto([_,_,A,A],[_,_,A,A],Board),
	var(A),
	A = s.

fill(Board,t):-
	transpose(Board,NewBoard),
	nextto([A,A,A,_],[_,A,_,_],NewBoard),
	var(A), 
	A = t.

fill(Board,t):-
	transpose(Board,NewBoard),
	nextto([_,A,A,A],[_,_,A,_],NewBoard),
	var(A),
	A = t.

fill(Board,t):-
	transpose(Board,NewBoard),
	nextto([_,A,_,_],[A,A,A,_],NewBoard),
	var(A),
	A = t.

fill(Board,t):-
	transpose(Board,NewBoard),
	nextto([_,_,A,_],[_,A,A,A],NewBoard),
	var(A),
	A = t.

fill(Board,t):-
	nextto([A,A,A,_],[_,A,_,_],Board),
	var(A),
	A = t.

fill(Board,t):-
	nextto([_,A,A,A],[_,_,A,_],Board),
	var(A),
	A = t.

fill(Board,t):-
	nextto([_,A,_,_],[A,A,A,_],Board),
	var(A),
	A = t.

fill(Board,t):-
	nextto([_,_,A,_],[_,A,A,A],Board),
	var(A),
	A = t.

fill(Board,l):-
	nextto([A,_,_,_],[A,A,A,_],Board),
	var(A),
	A = l.

fill(Board,l):-
	nextto([_,A,_,_],[_,A,A,A],Board),
	var(A),
	A = l.

fill(Board,l):-
	nextto([A,A,A,_],[_,_,A,_],Board),
	var(A),
	A = l.

fill(Board,l):-
	nextto([_,A,A,A],[_,_,_,A],Board),
	var(A),
	A = l.

fill(Board,l):-
	threeConsecutive(R1,R2,R3,Board),
	R1 = [_,A,_,_],
	R2 = R1,
	R3 = [A,A,_,_],
	var(A),
	A = l.

fill(Board,l):-
	threeConsecutive(R1,R2,R3,Board),
	R1 = [_,_,A,_],
	R2 = R1,
	R3 = [_,A,A,_],
	var(A),
	A = l.

fill(Board,l):-
	threeConsecutive(R1,R2,R3,Board),
	R1 = [_,_,_,A],
	R2 = R1,
	R3 = [_,_,A,A],
	var(A),
	A = l.

fill(Board,l):-
	threeConsecutive(R1,R2,R3,Board),
	R1 = [A,A,_,_],
	R2 = R1,
	R3 = [A,_,_,_],
	var(A),
	A = l.

fill(Board,l):-
	threeConsecutive(R1,R2,R3,Board),
	R1 = [_,A,A,_],
	R2 = R1,
	R3 = [_,A,_,_],
	var(A),
	A = l.

fill(Board,l):-
	threeConsecutive(R1,R2,R3,Board),
	R1 = [_,_,A,A],
	R2 = R1,
	R3 = [_,_,A,_],
	var(A),
	A = l.

