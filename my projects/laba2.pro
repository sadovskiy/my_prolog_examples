%╠юыюфЎютр ╦
%╨юцъют ╤
%┴юуэрўхт └

domains

       SP=integer*

predicates

          w(integer,integer,SP)
          r(integer,integer)
          print(SP)
          find_all(integer,integer)
          a(SP,SP,SP)

clauses

       r(1,4).
       r(1,2).
       r(3,7).
       r(4,3).
       r(4,8).
       r(5,6).
       r(6,10).
       r(7,5).
       r(8,7).
       r(8,9).
       r(9,6).
       r(9,10).
       
       w(A,B,Res):-
                   r(A,B), a([A],[B],Res).
       w(A,B,Res):-
                   r(A,X),w(X,B,Res), a([X],[B],Res).
       a([],L,L).
       a([H|A],B,[H|C]):-
                         a(A,B,C).
       find_all(X,Y):-
                      w(X,Y,Res),print(Res),fail.
       find_all(_,_).
       print([]).
       print([Res|H]):-
                       write(Res),print(H).

