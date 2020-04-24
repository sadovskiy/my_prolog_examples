/******************************************************************************

	Demonstration of functorless structs

  Inspect under debugger to see the effect


 ���������������������������������������������������������������������������
  Date Modified,� By,  �  Comments.
 ���������������������������������������������������������������������������
                �      �
******************************************************************************/

DOMAINS
  DATE =	struct date(YEAR,MONTHS,DAY)
  TIME =	struct time(HOUR,MIN,SEC)
  FULLDATE =	struct full(DATE,TIME)

  YEAR, MONTHS, DAY, HOUR, MIN, SEC = INTEGER

PREDICATES
  get_date(DATE)
  get_time(TIME)

CLAUSES
  get_date(date(Y,M,D)):-
	date(Y,M,D).

  get_time(time(H,M,S)):-
	time(H,M,S,_).


GOAL
	get_date(DATE),
	get_time(TIME),
	FULLDATE = full(DATE,TIME),
	write("\nThe full date structure are: ",FULLDATE).
