domains 

	list = integer *

predicates

	connect(integer, integer)
	way(integer, integer, list)

clauses

	connect(1, 2).
	connect(1, 4).
	connect(2, 3).
	connect(2, 5).
	connect(4, 5).
	connect(5, 6).
	connect(3, 7).
	connect(6, 7).
	connect(7, 9).
	connect(7, 8).
	connect(8, 10).


	way(X, Z, [X|[Z]]):-
		connect(X, Y), 
		way(Y, Z, T). 

	way(X, Z, L):-
		connect(X, Z).
	
