
graph_size(6).
start(1).
dest(6).
edge(1,2,4).
edge(1,3,2).
edge(2,3,5).
edge(2,4,10).
edge(3,5,3).
edge(4,5,4).
edge(4,6,11).

%graph_size(6).
%start(1).
%dest(5).
%dest(6).
%edge(1,2,6).
%edge(1,3,1).
%edge(1,4,5).
%edge(2,3,5).
%edge(2,5,3).
%edge(3,4,5).
%edge(3,5,6).
%edge(3,6,4).
%edge(4,6,2).

path(Start,Dest,[Dest],_,Cost):-
	edge(Start,Dest,Cost).

path(Start,Dest,[Dest],_,Cost):-
	edge(Dest,Start,Cost).


path(Start,Dest,Path,Vertices,Cost):-
	select(Intermediate,Vertices,NewVertices),
	(edge(Start,Intermediate,InterCost);edge(Intermediate,Start,InterCost)),
	path(Intermediate,Dest,InterPath,NewVertices,InterDestCost),
	append([Intermediate],InterPath,Path),
	Cost is InterCost + InterDestCost.

pathEntry(Start,Destination,Path,Vertices,Cost):-
	path(Start,Destination,Path1,Vertices,Cost),
	Path = [Start|Path1].


shortestPath(Start,Dest,ShortestPath):-
	
	findall([P,C],pathEntry(Start,Dest,P,[2,3,4,5],C),L),
	%ShortestPath = L.
	select(Path,L,RemPaths),
	minOfAll(Path,RemPaths),
	ShortestPath = Path.

minOfAll(_,[]).
minOfAll([P1,C1],[[_,C2]|T]):-
	C1 =< C2,
	minOfAll([P1,C1],T).

newEnter(R):-
	start(Source),
	dest(Destination),
	shortestPath(Source,Destination,R).

allPathsToAllDestinations(Paths):-
	findall(R,newEnter(R),Paths).

minCost(Cost):-
	allPathsToAllDestinations(Paths),
	minCostHelper(Paths,Cost).
	
minCostHelper(Paths,Cost):-
	select([Path1,_],Paths,RemPaths),
	select([Path2,_],RemPaths,[]),
	processPath(Path1,Path2,Cost).
minCostHelper([[_,Cost]],Cost).

processPath([H1Start,H1End|T1],[H1Start,H1End|T2],Cost):-
	processPath([H1End|T1],[H1End|T2],Cost1),
	edge(H1Start,H1End,Cost2),
	Cost is Cost1 + Cost2.

processPath([H1Start,H1End|T1],[H1Start,H2End|T2],Cost):-
	H1End \= H2End,
	edge(H1Start,H1End,Cost1),
	edge(H1Start,H2End,Cost2),
	processPath([H1End|T1],[H2End|T2],Cost3),
	Cost is Cost1 + Cost2 + Cost3.

processPath([H1Start,H1End|T1],[H2Start,H1End|T2],Cost):-
	H1Start \= H2Start,
	edge(H1Start,H1End,Cost1),
	edge(H2Start,H1End,Cost2),
	processPath([H1End|T1],[H1End|T2],Cost3),
	Cost is Cost1 + Cost2 + Cost3.

processPath([H1Start,H1End|T1],[],Cost):-
	edge(H1Start,H1End,Cost1),
	processPath([H1End|T1],[],Cost2),
	Cost is Cost1 + Cost2.

processPath([],[H1Start,H1End|T1],Cost):-
	edge(H1Start,H1End,Cost1),
	processPath([],[H1End|T1],Cost2),
	Cost is Cost1 + Cost2.

processPath(_,_,0).



