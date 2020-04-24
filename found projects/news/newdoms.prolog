/******************************************************************************

	Demonstration of new numeric domains

  Test the behaviour and overflow checking for the new domains
  in goal mode !.

  For the ranges see the file range.pre in the include directory

  ( for the new binarry domain see termconv.pro )

 อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
  Date Modified,บ By,  บ  Comments.
 อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
                บ      บ
******************************************************************************/

DOMAINS
  my_byte =	byte
  my_short =	short
  my_ushort =	ushort
  my_word =	word
  my_unsigned =	unsigned
  my_long =	long
  my_ulong = 	ulong
  my_dword = 	dword
  returndom =	signed dword

PREDICATES
  p_byte(byte,my_byte,returndom)
  p_short(short,my_short,returndom)
  p_ushort(ushort,my_ushort,returndom)
  p_word(word,my_word,returndom)
  p_unsigned(unsigned,my_unsigned,returndom)
  p_long(long,my_long,returndom)
  p_ulong(ulong,my_ulong,returndom)
  p_dword(dword,my_dword,returndom)

  testval(returndom)
  testcast(returndom)
  testround(returndom)
  testtrunc(returndom)

CLAUSES
  p_byte(X,Y,Z):-    Z=X+Y.
  p_short(X,Y,Z):-   Z=X+Y.
  p_ushort(X,Y,Z):-  Z=X+Y.
  p_word(X,Y,Z):-    Z=X+Y.
  p_unsigned(X,Y,Z):-Z=X+Y.
  p_long(X,Y,Z):-    Z=X+Y.
  p_ulong(X,Y,Z):-   Z=X+Y.
  p_dword(X,Y,Z):-   Z=X+Y.
  
  % val is the clean way to assign a given domain to a constant or an expression
  testval(RET):-
	RET = val(returndom,0).

  % cast converts any domain to any domain without any checking
  testcast(RET):-
	RET = cast(returndom,"Hello").

  % round and trunc does now deliver a real as the resulting value
  testround(RET):-
	RET = round(9999999.99).

  testtrunc(RET):-
	RET = trunc(9999999.99).

% GOAL p_byte(100,100,_).
