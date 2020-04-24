trace
        /*
        NeedList - Список нужных городов
        ReadyList - уже проехали
        Прибавляем к ReadyList первый элт из NeedList
        */

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
                path( city, int,cities)
                globalPred
              /*  append( cities, cities, cities)*/
                assertTowns(cities)
                no_endWay( city, cities, int )
                getTown(city)
                go
       database
         road( city, city, int).
         route( cities ).
         rekord(int).
         town(city).
         mypath(cities).

       goal
         consult("map.txt"),
         assertz(rekord(9999)),
         globalPred.


       clauses

  /*         append( [], List, List).
           append( [H|List1], List2, [H|ResList] ) :-
             append( List1, List2, ResList).*/

           assertTowns([]).
           assertTowns([H|T]) :-
               assert(town(H)),
               assertTowns(T).

           no_endWay( CurTown, CurWay, Rekord ) :-
               retract(town(CurTown));
               retract(myPath(_) ),
               assert(myPath(CurWay) ),
               retract(rekord(_)),
               assert(town(CurTown)),
               assert(rekord(Rekord));
               true.
           getTown(Twn) :- town(Tn), Twn=Tn;True.

           path( BegCity, Dist, Way) :-
               town(X),
               road(BegCity, X, Dist1),
               rekord(Rek),
               Rek>Dist+Dist1,
               Dist2 = Dist1+Dist,
               no_endWay( X, Way, Dist2 ),
               not( path( X, Dist2, [X|Way] )),
               0=1.

           go :-
             town(X),
             N =1,
             fail.

          globalPred :-
             assert(mypath([])),
             route( [BegCity|OtherCities]),
      trace ( off),
             assertTowns(OtherCities),
      trace ( on),
             rekord(CurRekord),
             not ( path( BegCity, 0, []) ),
             rekord(CurRekord),
             write( CurRekord ).
