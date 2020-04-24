%trace
domains
    point = symbol
    path = point*
predicates
%    go(point,point)
    member(point,path)	
    path1(point,path,path)
    ac_path(point,point,path)
    intface
    Writing(point,point)
    print 
database
    go(point,point)    
clauses
%    go(a,b).
%    go(a,c).
%    go(b,d).
%    go(c,b).
%    go(c,e).
%    go(d,c).
%    go(d,e).
  intface:-
      makewindow(1,20,5,"",0,0,25,80),
      makewindow(1,20,5,"",3,14,3,52),
      write("   ���������� ���� ������������ ����� � �����  "),
      field_attr(0,0,50,110),
      makewindow(3,7,4,"",7,14,10,52),
      clearwindow.
 print:-nl,
      write(" � �ਥ��஢����� ��� 5 ���設,<a>-��砫쭠�."),nl,
      write(" �� ������ ���設� ���� ᫥���騥 ���:"),nl,
      write("           a: � ���設� <b>,<c> "),nl,     
      write("           b: � ���設� <d> "),nl,
      write("           c: � ���設� <b>,<e> "),nl,
      write("           d: � ���設� <c>"),nl,
      write("           e: ��⥩ �� ��� ���."),nl,
      write(" ��� �த������� ������ ���� �������"),
      readchar(_),
      field_attr(0,0,50,110),
      makewindow(3,7,4,"",7,13,16,54),
      clearwindow.


      Writing(X,Y):-nl,write("    ���� ���������� � ��������� ������� � �����"),nl,nl,
                  write(" ������� ��������� �������:  "),
                  readln(X),
                  write(" ������� �������� ������� :  "),
                  readln(Y),
                  write("             ������� ��������� ����:"),nl,
                  nl.
    ac_path(A,Z,P) :- path1(A,[Z],P).
    path1(A,[A|P1],[A|P1]).
    path1(A,[Y|P1],P) :- go(X,Y),
    	                 not(member(X,P1)),
    	                 path1(A,[X,Y|P1],P).
    member(X,[X|_]).
    member(X,[_|P]) :- member(X,P).
 goal
     assert(go(a,b)),
     assert(go(a,c)),
     assert(go(b,d)),
     assert(go(c,b)),
     assert(go(c,e)),
     assert(go(d,c)),
     assert(go(d,e)),
     intface,
     print,
     Writing(X,Y),
     ac_path(X,Y,L),
     write("  "),
     write(L,"\n"),fail. 


