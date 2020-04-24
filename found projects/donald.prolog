%trace
domains
 int=integer
 list=int*
predicates
 sum( list, %  слово1
      list, % +слово2
      list  % =слово3
    )

 sum1(
      list, % слово1
      list, % слово2
      list, % слово3
      int,  % перенос до
      int,  % перенос после
      list, % множество свободных чисел до
      list  % множество свободных чисел после
     )

 sumc(
      int,  %  число1
      int,  % +число2
      int,  % +перенос
      int,  % =число3
      int,  % новый перенос
      list, % множество свободных чисел до
      list  % множество свободных чисел после
     )

 del(int,list,list) % Удаление элемента списка

goal
 nl,nl,nl,nl,nl,
 write("Решение ребуса"),nl,
 write("  DONALD"),nl,
 write("+       "),nl,
 write("  GERALD"),nl,
 write("--------"),nl,
 write("  ROBERT"),nl,nl,
 sum([D,O,N,A,L,D],[G,E,R,A,L,D],[R,O,B,E,R,T]),
 write(' ',D,' ',O,' ',N,' ',A,' ',L,' ',D),nl,
 write(" D O N A L D"),nl,
 write(' ',G,' ',E,' ',R,' ',A,' ',L,' ',D),nl,
 write(" G E R A L D "),nl,
 write("+"),nl,
 write("------"),nl,
 write(' ',R,' ',O,' ',B,' ',E,' ',R,' ',T),nl,
 write(" R O B E R T").
clauses

 sum(N1,N2,N):- %{ Складываем строки }
     sum1( N1 , N2 , N , 0 , 0 , [0,1,2,3,4,5,6,7,8,9],_).
                                %{ все цифры свободны }
 sum1([],[],[],0,0,Cfrs,Cfrs).
      %{ Прекратить поиск решения если символов больше нет }

 sum1([D1|N1],[D2|N2],[D|N],C1,C,Cfr1,Cfr):-
     sum1(N1,N2,N,C1,C2,Cfr1,Cfr2),
     sumc(D1,D2,C2,D,C,Cfr2,Cfr).

 sumc(D1,D2,C1,D,C,Cfr1,Cfr):-%{Сложить две цифры с учетом переноса }
             del(D1,Cfr1,Cfr2),
             del(D2,Cfr2,Cfr3),
             del(D,Cfr3,Cfr),
             S = D1+D2+C1,
             D = S mod 10,
             C = S div 10.

 del(A,L,L):-bound(A),!.

 del(A,[A|L],L).

 del(A,[B|L],[B|L1]):-del(A,L,L1).
