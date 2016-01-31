resolve(neg(X),or(X,A),A).
resolve(neg(X),or(A,X),A).
resolve(or(A,X),neg(X),A).
resolve(or(X,A),neg(X),A).
resolve(neg(neg(X)),Y,A):-
	resolve(X,Y,A).
resolve(Y,neg(neg(X)),A):-
	resolve(Y,X,A).
resolve(or(X,X),Y,A):-
	resolve(X,Y,A).
resolve(Y,or(X,X),A);-
	resolve(Y,X,A).

resolve(neg(X),X,empty).
resolve(X,neg(X),empty).

length2([],0).
length2([_|Xs],M):-
	length2(Xs,N),
	M is N+1.

add(X,[],[X]).
add(X,[H|T],[H|R]):-
        add(X,[T],R).

find(empty,empty,0).
find([H|_],H,0).

find([_|T],X,R):-
	find(T,X,R1),
	R is R1+1.

process(A,B,L):-
	resolve(A,B,empty),		
	add(empty,[],L).

process(H,[H1|T],L):-
	resolve(H,H1,R),
	append(T,R,L).

process(H,T,L):-
	append(T,[H],L).

process([],[],_,_).
process([H],H,_,_).

process(L,Result,I,N):-
	I<N,
	find(L,empty,R),
	write('success'),
	!.

process([H|T],Result,I,N):-
	I<N,
	process(H,T,Result1),
	I1 is I+1,
	process(Result1,Result,I1,N).

factorial(1,1).
factorial(N,R):-
	N1 is N-1,
	factorial(N1,R1),
	R is R1*N.

entry([],_,_).

entry(L,_,_):-
	find(L,empty,R),
	write('success').

entry(L,I,N):-
	I<N,
	\+find(L,empty,R),
	process(L,L1,I,N),
	I1 is I+1,
	entry(L1,I1,N).

enter(L):-
	terminalValue(L,R),
	!,
	entry(L,0,R).	
	
terminalValue(L,R):-
	length2(L,F),
	factorial(F,R).
