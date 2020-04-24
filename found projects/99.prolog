       /*
       NeedList - ���᮪ �㦭�� ��த��
       ReadyList - 㦥 �஥堫�
       �ਡ���塞 � ReadyList ���� �� �� NeedList
       */
       /* ���� ��� */
       path( begcity, [xcity|endcity], km ) :- road( begcity, endcity, km).
       path( begcity, [xcity|endcity], km ) :-
         path( city, X, km ),

       path( [begcity], [endcity], Dist) :- road( begcity, endcity, km).

       lastElem( [T], Tail).
       lastElem( List, Tail) :- LastElem( [H|T], Tail).
       path(ReadyList, [], Dist).
       path( ReadyList, NeedList, Dist) :-
         path( ReadyList, [H|T], Dist) :-
           append( ReadyList, H, ReadyList1 ),
           lastElem( ReadyList, LastHere),
           road( LastHere, endcity, km1),
           path( ReadyList, [H|T], km2),
           Dist = km1+km2
           .

       domains
               city = symbol
               cities = city*
               path = city*
               way = way( city, city)
               ways = way*
               pathes = path*


       predicates
               repeat


               inList( way, ways)
               inList( city, path)
               inList( city, cities)
               inList( path, pathes)
               enumItems( ways, integer)
               enumItems( cities, integer)
               append( pathes, pathes, pathes)

               existWay( city, city)

               path( city, city)
               path1( city, path)
               findPath( city, city)
               is_found( integer)

               inputMap( char)
               inputMap1
               inputMap4
               inputWay( integer, cities, ways)
               includeCity( city, cities, cities)
               nondeterm includeWay( way, ways, ways)

               endFind
       clauses

       repeat.
       repeat :-
               repeat
               .

       /****************************************************************/
       /*      ����� � ᯨ᪠��                                      */
       /****************************************************************/

       inList( Item, [Item | _]).
       inList( Item, [_ | Tail]) :-
               inList( Item, Tail)
               .

       enumItems( [], 0).
       enumItems( [_ | List], NumItems) :-
               enumItems( List, SubNumItems),
               NumItems = SubNumItems + 1
               .

       append( [], List, List).
       append( [Item | L1], L2, [Item | L3]) :-
               append( L1, L2, L3)
               .

       /****************************************************************/
       /*      ����� � ���⮩                                         */
       /****************************************************************/

       existWay( X, Y) :-
               map( _, Ways),
               inList( way( X, Y), Ways)
               .

       /****************************************************************/
       /*      ����                                                   */
       /****************************************************************/

       found_count( 0).

       pathes( []).

       path1( BegCity, [BegCity | CurPath]) :-
               !,
               L = [BegCity | CurPath],
               pathes( Pathes),
               not( inList( L, Pathes)),
               append( Pathes, [L], NewPathes),
               retract( pathes( _)),
               assert( pathes( NewPathes)),
               nl, write( "    "), write( L),
               found_count( F),
               retract( found_count( _)),
               NF = F + 1,
               assert( found_count( NF)),
               !, fail
               .
       path1( BegCity, [CurCity | CurPath]) :-
               existWay( NextCity, CurCity),
               not( inList( NextCity, CurPath)),
               path1( BegCity, [NextCity, CurCity | CurPath])
               .
       path( BegCity, EndCity) :-
               path1( BegCity, [EndCity])
               .
       path( _, _).

       is_found( 0) :-
               nl, write( "    ���"), !
               .
       is_found( N) :-
               nl, write( "�ᥣ�: "), write( N)
               .

       findPath( BegCity, EndCity) :-
               path( BegCity, EndCity),
               found_count( F),
               is_found( F)
               .

       /****************************************************************/
       /*      ���� �����                                              */
       /****************************************************************/

       inputMap( 'y') :-
               inputMap4.
       inputMap( 'Y') :-
               inputMap4.
       inputMap( _) :-
               inputMap1.

       inputMap1 :-
               write( "���"),
               assert( map(
                       [a, b, c, d, e],
                       [ way(a, b), way(b, c), way(c, a)
                       , way(b, d), way(c, d), way(b, e), way(c, e)
                       , way(d, a)])
                       )
               .


       inputMap4 :-
               write( "��"),
               nl, write( "������ ������⢮ ��⥩: "),
               readint( NumWays),
               inputWay( NumWays, Cities, Ways),
               enumItems( Cities, NumCities),
               nl, write( "�ᥣ� ��த��: ", NumCities),
               assert( map( Cities, Ways))
               .

       inputWay( 0, [], []).
       inputWay( NumWays, Cities, Ways) :-
               NewNumWays = NumWays - 1,
               inputWay( NewNumWays, Cities1, Ways1),
               repeat,
               nl, write( "���� #", NumWays), nl,
               write( "    ���.��த: "), readln( City1),
               write( "    ���.��த: "), readln( City2),
               includeWay( way( City1, City2), Ways1, Ways),
               includeCity( City1, Cities1, Cities2),
               includeCity( City2, Cities2, Cities)
               .

       includeCity( City, [], [City]).
       includeCity( City, [City | OtherCities], [City | OtherCities]).
       includeCity( City, [City0 | OtherCities], [City0 | NewCities]) :-
               includeCity( City, OtherCities, NewCities)
               .

       includeWay( way(City1, City2), [], [way( City1, City2)]).
       includeWay( way(City1, City2), [way(City1, City2) | OtherWays], [way(City1, City2) | OtherWays]) :-
               write( "���� ����� �⨬� ��த��� 㦥 ������! ������ ����."), nl,
               !, fail.
       includeWay( way(City1, City2), [Way0 | OtherWays], [Way0 | NewWays]) :-
               includeWay( way(City1, City2), OtherWays, NewWays)
               .

       /****************************************************************/
       /*      �஢�ઠ �ᯥ譮�� ���᪠                              */
       /****************************************************************/

       endFind :-
               beep,
               retract( map( _, _)),
               retract( found_count( _)),
               assert( found_count( 0))
               .





       domains
               town = string
               townS = town*
               need_towns = townS
               all_town = townS
               path = townS
               way = way( town, town )
               ways = way*
               pathes = path*

