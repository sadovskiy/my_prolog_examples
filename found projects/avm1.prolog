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
      write("   НАХОЖДЕНИЕ ВСЕХ АЦИКЛИЧЕСКИХ ПУТЕЙ В ГРАФЕ  "),
      field_attr(0,0,50,110),
      makewindow(3,7,4,"",7,14,10,52),
      clearwindow.
 print:-nl,
      write(" В ориентированном графе 5 вершин,<a>-начальная."),nl,
      write(" Из каждой вершины есть следующие пути:"),nl,
      write("           a: в вершины <b>,<c> "),nl,     
      write("           b: в вершину <d> "),nl,
      write("           c: в вершины <b>,<e> "),nl,
      write("           d: в вершину <c>"),nl,
      write("           e: путей из нее нет."),nl,
      write(" Для продолжения нажмите любую клавишу"),
      readchar(_),
      field_attr(0,0,50,110),
      makewindow(3,7,4,"",7,13,16,54),
      clearwindow.


      Writing(X,Y):-nl,write("    ВВОД НАЧАЛЬНОГО И КОНЕЧНОГО ПУНКТОВ В ГРАФЕ"),nl,nl,
                  write(" ВВЕДИТЕ НАЧАЛЬНУЮ ВЕРШИНУ:  "),
                  readln(X),
                  write(" ВВЕДИТЕ КОНЕЧНУЮ ВЕРШИНУ :  "),
                  readln(Y),
                  write("             НАЙДЕНЫ СЛЕДУЮЩИЕ ПУТИ:"),nl,
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


