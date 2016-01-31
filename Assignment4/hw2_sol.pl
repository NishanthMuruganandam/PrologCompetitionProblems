% Q1. Refutation.  
refutation(G, R) :-
	listify(G, [], Gs), % First represent a goal as a sequence (list) of subgoals).
	eval_r(Gs, R).	    % Then evaluate this list, collecting the sequence of goals.

eval_r([], []).			% Empty goal: refutation succeeds.
eval_r([G|Gs], [ Goal | R]) :-  % non-empty goal:
	Goal = [G|Gs],		%  Select a literal (first: OLD)
	clause(G, B),		% unify with a clause in program,
	listify(B, Gs, G1s),    % add the body literals to form the new goal
	eval_r(G1s, R).		% and evaluate the new goal.
	

% Q2. Loop-free derivations.
lfd(G) :-
	listify(G, [], Gs),
	eval_l([], Gs).

% eval(L, G): a refutation of G exists, whose goals do not intersect with L.
eval_l(L, G) :-
	\+ basics:member(G, L),  % fail if G is in L
	eval_lfd([G|L], G).      % otherwise, add G to history, and look for a refutation.

eval_lfd(_, []).		% Empty goal: refutation succeeds
eval_lfd(L, [G1|Gs]) :-		% non-empty goal: 
	clause(G1, B),		%  select first literal, resolve with a program clause
	listify(B, Gs, G1s),
	eval_l(L, G1s).		% and continue searching for a loop-free refutation.

% common: convert a (comma-separated) goal to a list of atoms.
listify((G1, G2), Gs, G1s) :- !,
	listify(G2, Gs, G2s),
	listify(G1, G2s, G1s).
listify(true, Gs, Gs) :- !.
listify(G, Gs, [G|Gs]).

