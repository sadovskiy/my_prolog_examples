/******************************************************************************

	Demonstration of sizeof function

 อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
  Date Modified,บ By,  บ  Comments.
 อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
                บ      บ
******************************************************************************/

DOMAINS
  DOM = struct f(INTEGER)
  DOM1 = align word f(integer,integer,long); g(STRING)
  REFINT = reference integer
  FUNC = determ (integer) - (i)

PREDICATES
  refint(REFINT)

CLAUSES
  refint(_).

GOAL	% Find the size of a domain with a single alternative
	A = sizeof(DOM),
	write("\nSize=",A),

	% when there are alternatives the largest are reurned
	B = sizeof(DOM1),
	write("\nSize=",B),

	% Find size of a single alternative
	C = sizeof(DOM1,g),
	write("\nSize=",C),

	% Find size of a struct pointed to by a variable
	X = f(1,1,1),
	D = sizeof(X),
	write("\nSize=",D),

	% Find size of a string pointed to by a variable
	Y = "hello there",
	E = sizeof(Y),
	write("\nSize=",E),

	% Find size of a reference variable
	refint(Z),
	F = sizeof(Z),
	write("\nSize=",F).
