

GLOBAL DOMAINS
  CALLBACK1 = determ (integer,integer) - (i,i) language c
  CALLBACK2 = determ string (integer) - (i) language c
  CALLBACK3 = determ () language c


GLOBAL PREDICATES
  event_handler1 : CALLBACK1 as "_handler1_"

  CALLBACK1 get_proc() language c

  b1: CALLBACK3
  b2: CALLBACK3
  b3: CALLBACK3


DOMAINS
  LIST = CALLBACK3*


PREDICATES
  event_handler2 : CALLBACK2
  p(CALLBACK1,CALLBACK2)
  nondeterm member(CALLBACK3,LIST)
  listtest(LIST)


CLAUSES
  event_handler1(X,Y):-
	write("\nEvent handler1: X=",X,", Y=",Y).

  % Local function that returns the integer formatted to a string
  event_handler2(INT,STR):-
	str_int(STR,INT).

  p(X,Y):-
	X(9,9),
	Ret = Y(1),
	write("\nReturn val = ",Ret).

  member(X,[X|_]).
  member(X,[_|L]):-
	member(X,L).

  b1:-write("\nHi this is b1").
  b2:-write("\nHi this is b2").
  b3:-write("\nHi this is b3").

  listtest(LIST):-
	member(X,LIST),
	  X(),
	fail.
  listtest(_).


GOAL
	PROC1 = event_handler1,
	p(PROC1,event_handler2),
	L=[b1,b2,b3],
	write(L),
	listtest(L).

