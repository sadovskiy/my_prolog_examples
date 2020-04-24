/******************************************************************************

	Demonstration of return valuess

	Example on how to call some C routines in the PDC Prolog library
	and how to define functions

 อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
  Date Modified,บ By,  บ  Comments.
 อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
                บ      บ
******************************************************************************/


GLOBAL PREDICATES

  % void * MEM_AllocGStack(UNSIGNED size);
  string alloc(integer) - (i) language c as "_MEM_AllocGStack"

  % UNSIGNED STR_StrLen(CHAR *);
  unsigned slen(STRING)- (i) language c as "_STR_StrLen"

  % void STR_StrCat(CHAR *Dest,CHAR *Source);
  strcat(string,string) - (i,i) language c as "_STR_StrCat"

  % void STR_StrCat0(CHAR *Dest,CHAR *Source);
  strcat0(string,string) - (i,i) language c as "_STR_StrCat0"

  % LONG pascal LONG_Mul(LONG,LONG);
  LONG long_mul(LONG,LONG) - (i,i) language pascal

  % void OS_Date_ooo(UNSIGNED *Year,UNSIGNED *Month,UNSIGNED *Day);
  integer mydate(integer,integer,integer)-(o,o,o) language c as "_OS_Date_ooo"


PREDICATES
  STRING substr(INTEGER,INTEGER,STRING)
  LONG  add(LONG,LONG)

CLAUSES
  substr(START,LEN,IN,OUT):-
	frontstr(START,IN,_,REST),
	frontstr(LEN,REST,OUT,_).

  add(X,Y,Z):-
	Z = X+Y.


GOAL
	write("\nHello"),

	% Demonstrate functions in expressions
	X = 2*slen("X") * (10 - slen("hej")),
	write("\nFourteen=",X),

	% Demonstrate return of pointers
	S = alloc(100),
	strcat0(S,"Hi"),
	strcat(S," There"),
	nl,write(S),

	% Demonstrate return of long's and calling pascal func
	Nine = long_mul(3,3),
	write("\nNine=",Nine),

	% Demonstrate output parameters in a function
	Dummy = mydate(Year,Month,Day),
	writef("\nDate=%/%/%   dummy=%",Year,Month,Day,Dummy),

	SubStr = substr(6,5,"hello world"),
	nl,write("Substr=",SubStr),
	Five=add(2,3),
	nl,write("Five=",Five),nl.

