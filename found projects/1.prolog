
       domains
               city = symbol
               cities = city*
               path = city*
               way = way( city, city)
               ways = way*
               pathes = path*
               int = integer
               dist = int

       predicates
                path( city, cities, int)
                globalPred
                
                firstequal( cities, cities)
                append( cities, cities, cities)
                newrekord(cities, int)

       database
         road( city, city, int).
         one_city(city).
         route( cities ).
         rekord(int).

       goal
         consult("map.txt"),
         assertz(rekord(9999)),
         globalPred.


       clauses

           append( [], List, List).
           append( [H|List1], List2, [H|ResList] ) :-
             append( List1, List2, ResList).

           fillDataBase([]).
           fillDataBase( [H|T] ) :- assertz(H), fillDataBase( T ) .

           path( _, [], 0).
           path( CurCity, , Dist1) :-
               rekord(CurRekord),
               Dist1<CurRekord,
               newrekord([H|T], Dist1),
               append( T, [H], L),
               not(firstequal(L, [H|T] )),
               road( CurCity, H, Dist2),
               Dist = Dist2+Dist1,
               path( H, L, Dist).

           firstequal( [H1|T1], [H2|T2] ) :- H1 = H2.

           newrekord(List, Rekord) :-
               List = [],
               retract(rekord(_)),
               assertz(rekord(Rekord));
               True.


           path( _, [], 0).
           path( CurCity, [H|T], Dist1) :-
               rekord(CurRekord),
               Dist1<CurRekord,
               newrekord([H|T], Dist1),
               append( T, [H], L),
               not(firstequal(L, [H|T] )),
               road( CurCity, H, Dist2),
               Dist = Dist2+Dist1,
               path( H, L, Dist).

          globalPred :-
             route( [BegCity|OtherCities]),
             rekord(CurRekord),
             CurRek = CurRekord - 1,
             path( BegCity, OtherCities, CurRek),
             rekord(CurRekord),
             write( CurRekord ).