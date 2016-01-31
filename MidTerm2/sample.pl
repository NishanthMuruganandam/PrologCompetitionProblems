append(X-Y,Y-Ys,X-Y-Ys ).

add(X,Y-[X|Zs],Y-Zs).

palindrome(X):-
	palindromeHelp(X-[]).

palindrome(A-A).
palindromeHelp([_|A]-A).
palindromeHelp([C|A]-B):-
	palindromeHelp(A-B),
	B = [C|B].
