/******************************************************************************

	Demonstration of the binary type

 อออออออออออออออหออออออหออออออออออออออออออออออออออออออออออออออออออออออออออออ
  Date Modified,บ By,  บ  Comments.
 อออออออออออออออฮออออออฮออออออออออออออออออออออออออออออออออออออออออออออออออออ
                บ      บ
******************************************************************************/

% Implementation of binary:

%      ฺฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ 
%      ณSizeณbytes                 ณ
%      ภฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
%            ^
%            |
%  A binary points directly to some binary data, but just
%  before the data, the size indicates the number of bytes
%
%  In this way a binary can safely be asserted and changed in Prolog
%  and directly passed to foreign languages.

/* 
  % Create a new binary with a given number of bytes
  % BINARY MakeBinary(NoOfBytes)
  BINARY MakeBinary(UNSIGNED) - (i)

  % Create a binary from an existing pointer and a given size
  % BINARY ComposeBinary(PTR,SIZE)
  BINARY ComposeBinary(STRING,UNSIGNED) - (i,i)

  % BINARY MakeArray(NoOfElements,ElemSize)
  BINARY MakeArray(UNSIGNED,UNSIGNED) - (i,i)

  % Return number of bytes in binary
  UNSIGNED GetBinarySize(BINARY) - (i)

  % Value = Get*Entry(Array, Index)
  %Indexing are zero relative; and range checking are performed
  BYTE GetByteEntry(BINARY, UNSIGNED) - (i,i)
  WORD GetWordEntry(BINARY, UNSIGNED) - (i,i)
  DWORD GetDWordEntry(BINARY, UNSIGNED) - (i,i)

  % Set*Entry(Array, Index, Value)
  SetByteEntry(BINARY, UNSIGNED, BYTE) - (i,i,i)
  SetWordEntry(BINARY, UNSIGNED, WORD) - (i,i,i)
  SetDWordEntry(BINARY, UNSIGNED, DWORD) - (i,i,i)
*/

PREDICATES
  test(BINARY)

CLAUSES
  test(Bin):-
	SetWordEntry(Bin,3,99),
	fail.

  % Changes are not undone on backtracking !
  test(Bin):-
	Size = GetBinarySize(Bin),
	X = GetWordEntry(Bin,3),
	write("\nSize=",Size," X=",X," bIN=",Bin).

GOAL
	% Allocate a binary chunk of 10 bytes
	Bin1 = MakeBinary(10),
	test(Bin1),

	% Allocate an array of ten elements of four bytes in size each
	Bin2 = MakeBinary(10,4),
	test(Bin2),

	% Illustrate the syntax of a binary
	Bin3 = $[ 0x9A, 99, 99, 99, 5, 6, 7, 8  ],
	test(Bin3),

	% Allocate only one byte to ilustrate the range checking
	Bin4 = MakeBinary(1),
	trap(test(Bin4),_,write("\nplanned exit because wrong index")).

