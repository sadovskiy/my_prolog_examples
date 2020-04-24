/******************************************************************************

		DOS version adjustment

  Under DOS, PDC Prolog takes advantage of some of the newer introduced
  DOS function calls.

  In PDC prolog 3.2x this has caused problems to many users running DOS 4.x
  on an IBM PC LAN since the network did not support the DOS function call
  6Ch which PDC Prolog uses to open a file.

  PDC Prolog has an internal variable which is during initialization set 
  to the actual DOS version number. If this variable is set back to for
  instance 3.1, PDC Prolog will only call DOS functions that was supported
  in DOS 3.1.

  If your program needs to run DOS 4.0 and open files on an IBM PC LAN that
  has still not implemented 6Ch you can use the code below to handle this.

 อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
  Date Modified,บ By,  บ  Comments.
 อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
                บ      บ
******************************************************************************/


GLOBAL PREDICATES
  OS_GetVersion(INTEGER,INTEGER) - (o,o) language c
  OS_SetVersion(INTEGER,INTEGER) - (i,i) language c

PREDICATES
  test_change(INTEGER)

CLAUSES
  test_change(Ver):-
	Ver>3,!,
	OS_SetVersion(3,3).  % Make PDC Prolog only issue DOS 3.3 calls
  test_change(_).

GOAL
	OS_GetVersion(High,Low),
	write("\nThe current DOS version is: ",High,'.',Low),
	test_change(High),
	OS_GetVersion(High1,Low1),
	write("\nChanged DOS version is: ",High1,'.',Low1).

