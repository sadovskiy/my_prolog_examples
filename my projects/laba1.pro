% Бородастов Д. В.
% Машошин Д. В.
% Садовский Б. С.

domains

	list = symbol*   % инцелизация константы как строки

predicates

	a2 ( list, list, list )
	a3 ( list, list, list, list )
	E ( list )
	T ( list )
	F ( list )
	P ( list )

clauses

	a2 ( [], L, L ).   % пустой список
	a2 ( [H|A], B, [H|C] ):-
		a2 ( A, B, C ).
	a3 ( L, L1, L2, L3 ):-
		a2 ( L1, T, L ), a2 ( L2, L3, T ).
       
       E ( L ):-
       		a3 ( L, L1, ["+"], L3 ), E( L1 ), T( L3 ).
       E ( L ):-
       		a3 ( L, L1, ["-"], L3 ), E( L1 ), T( L3 ).
       E ( L ):-
       		T ( L ).
       T ( L ):-
       		a3 ( L, L1, ["*"], L3 ), T( L1 ), F( L3 ).
       T ( L ):-
       		a3 ( L, L1, ["/"], L3 ), T( L1 ), F( L3 ).
       T ( L ):-
       		P ( L ).
       P ( L ):-
       		a3 ( L, L1, ["^"], L3 ), T(L1), F(L3).
       P ( L ):-
       		F ( L ).
       F ( L ):-
       		a3 ( L, ["("], L2, [")"] ), E( L2 ).
       F ( L ):-
       		L=[a].
