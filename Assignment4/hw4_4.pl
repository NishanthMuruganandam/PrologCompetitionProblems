resolve(X,or(neg(X),A),A).
resolve(X,or(A,neg(X)),A).
resolve(or(A,neg(X)),X,A).
resolve(or(neg(X),A),X,A).
resolve(neg(X),or(X,A),A).
resolve(neg(X),or(A,X),A).
resolve(or(A,X),neg(X),A).
resolve(or(X,A),neg(X),A).
resolve(neg(X),or(A,X),A).
resolve(neg(X),or(X,A),A).

resolve(neg(neg(X)),Y,A):-
	resolve(X,Y,A).
resolve(Y,neg(neg(X)),A):-
	resolve(Y,X,A).
resolve(or(X,X),Y,A):-
	resolve(X,Y,A).
resolve(Y,or(X,X),A):-
	resolve(Y,X,A).
resolve(X,X,X).

resolve(neg(X),X,empty).
resolve(X,neg(X),empty).

resolve(neg(neg(X)),A):-
	resolve(X,A).

resolve(X,X).
	
convertGoal(G,R):-
	negateGoal(G,R1),
	resolve(R1,R).
	
negateGoal(G,neg(G)).

delete([X|Ys],X,Ys).
delete([X|Xs],Y,[X|Zs]):-
	delete(Xs,Y,Zs).

permute([],[]).
permute([X|Xs],Ys) :-
	permute(Xs,Zs),
	delete(Ys,X,Zs).

prove(_,[],[]).

prove(A,[H|T],L):-
	(
	resolve(A,H,Result) 
	-> 
	append(T,[Result],L)
	;
	append([A],T,L1),
	append(L1,[H],L)
	).
	%prove(A,L1,L).

prove([]):-
	write('failure'),
	fail.
prove(L):-
	member(empty,L),
	write('success').

prove(L):-
	\+member(empty,L),
	length(L,1),
	write('failure'),
	fail.

prove([H|T]):-
	prove(H,T,L1),
	prove(L1).


enter(L1,G):-
	convertGoal(G,G1),
	append(L1,[G1],L),
	findall(X,permute(L,X),R),
	recur(R).

recur([H|T]):-	
	 (
	\+prove(H)
	-> recur(T)
	;
	true).
