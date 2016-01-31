:- use_module(library(clpfd)).

board_size(4).
pos(1,2). 
pos(2,4).
pos(3,1). 
pos(4,3).

delete([X|Ys],X,Ys).
delete([X|Xs],Y,[X|Zs]):-
	delete(Xs,Y,Zs).

permute([],[]).
permute([X|Xs],Ys) :-
	permute(Xs,Zs),
	delete(Ys,X,Zs).


diagonalCheck(_,_,[],[]).

diagonalCheck(R1,C1,[R2|RT],[C2|CT]):-
	DiffRow is R1 - R2,
	DiffCol is C1 - C2,
	AbsDiffRow is abs(DiffRow),
	AbsDiffCol is abs(DiffCol),
	AbsDiffRow \= AbsDiffCol,
	diagonalCheck(R1,C1,RT,CT).

check([],[]):- !.	
check([RH|RT],[CH|CT]):-
	\+ member(RH,RT),
	\+ member(CH,CT),
	diagonalCheck(RH,CH,RT,CT),
	check(RT,CT).

computeR([],[],[],[],0).
computeR([OldRH|OldRT],[OldCH|OldCT],[NewRH|NewRT],[NewCH|NewCT],V):-
	OldRH = NewRH ,
	OldCH = NewCH ,
	computeR(OldRT,OldCT,NewRT,NewCT,V).

computeR([_|OldRT],[_|OldCT],[_|NewRT],[_|NewCT],V):-
	computeR(OldRT,OldCT,NewRT,NewCT,V1),
	V is V1 + 1.

create(N,N,[N]):- !.

create(N,I,R):-
	I1 is I+1,
	create(N,I1,R1),
	append(R1,[I],R).

board(N,Row,Col,R):-
	create(N,1,RowTemp),
	sort(RowTemp,Row1),
	create(N,1,Col1),
	findall(Cols,permute(Col1,Cols),PossibleCols),
	member(Col2,PossibleCols),
	check(Row1,Col2),
	%write(Row1),
	%write('  '),
	%write(Col2),
	%nl,
	computeR(Row,Col,Row1,Col2,R).

min(N1,N2,R):-
	N1 =< N2,
	R is N1.
min(N1,N2,R):-	
	N2 < N1,
	R is N2.

minInList([],_,_).
minInList([OH],MinSoFar,Min):-
	min(OH,MinSoFar,Min).
minInList([OH|OT],MinSoFar,Min):-
	min(OH,MinSoFar,Min1),
	minInList(OT,Min1,Min).

moves(R):-
	board_size(N),
	findall(R,pos(R,_),Row),
	findall(C,pos(_,C),Col),
	findall(Rs,board(N,Row,Col,Rs),Results),
	%write(Results),
	minInList(Results,10000000,R).

