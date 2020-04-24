connection(1, 2).
connection(1, 4).
connection(2, 3).
connection(2, 5).
connection(4, 5).
connection(5, 6).
connection(3, 7).
connection(6, 7).
connection(7, 9).
connection(7, 8).
connection(8, 10).

way(X, Z, [X|[Z]]):-
		connection(X, Y), 
		way(Y, Z, T). 

way(X, Z, L):-
		connection(X, Z).
	
