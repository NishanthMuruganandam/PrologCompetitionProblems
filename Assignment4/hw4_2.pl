resolve(neg(X),or(X,A),A).
resolve(neg(X),or(A,X),A).
resolve(or(A,X),neg(X),A).
resolve(or(X,A),neg(X),A).

resolve(neg(X),X,empty).
resolve(X,neg(X),empty).

length2([],0).
length2([_|Xs],M):-
	length2(Xs,N),
	M is N+1.

delete([X|Ys],X,Ys).
delete([X|Xs],Y,[X|Zs]):-
	delete(Xs,Y,Zs).

permute([],[]).
permute([X|Xs],Ys) :-
	permute(Xs,Zs),
	delete(Ys,X,Zs).


add(X,[],[X]).
add(X,[H|T],[H|R]):-
        add(X,[T],R).

find(empty,empty,0).
find([H|_],H,0).

find([_|T],X,R):-
	find(T,X,R1),
	R is R1+1.

process([H1,H2],R):-
	resolve(H1,H2,R).

process([H1,H2|T],R):-
	process([H1|T],R1),
	append(T,R1,R).	


entry([],fail).

entry(L,success):-
	find(L,empty,R),
	write('success').

entry(L,Result):-
	\+find(L,empty,R),
	process(L,L1),
	entry(L1,Result).

enter(L,R):-
	permute(L,L1),
	entry(L1,R),
	permute(L1,L1),
	entry(L1,R).

