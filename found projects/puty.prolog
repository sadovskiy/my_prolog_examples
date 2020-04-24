%                        Идея метода
%
%   На основе заданного множества точек вершин графа строится опорное решение
% представляющее собой линейный связанный граф.
%   Множество точек вершин графа хранится в файле "point.bd" в виде структуры
% типа:      point(<имя вершины>,xy(<координата X>,<координата Y>)), редактируя 
% файл можно изменять структуру графа (графика настроена на описание структуры 
% графа в единичном квадрате).
%   Для построения опорного решения используется следующий алгоритм:
% 1. Выбирается произвольная точка множества А.
% 2. К ней присоединяется ближайшая точка В и тем самым формируется ребро
%    (А,В).
% 3. К точке В присоединяется следующая ближайшая точка и т.д.
%   Построенный связанный граф не обязательно обладает свойством оптимальности
% длинны графа, поэтому необходимо минимизировать опорное решение.
%   Для этого в построенном графе ищется самое длинное ребро и по этому ребру
% граф разрезается на две части. В соответствии с 2 полученными подграфами
% формируются два множества точек (вершин графов), ранее связанных между собой
% удаленным ребром. Между построенными множествами ищется ребро (две точки)
% наименьшей длины. Ранее удаленная связь (ребро) заменяется на новое ребро.
% Если длина нового ребра меньше чем длина старого ребра, то суммарная длина
% графа будет меньше.Такая процедура проделывается со всеми ребрами опорного
% решения.
%  Можно показать, что предложенный алгоритм стоит минимальный связанные граф.
%  Для визуализации результатов используются еще две программы RULET.PRO и
% GRAPDEC.PRO в которых реализуются настройки программ BGI-графики.
% Программы заимствованы из примеров языка ПРОЛОГ 2.0.    

%trace
% wrigra
include "rulet.pro"

CONSTANTS
npic = 500
mpic = 500
xmin = -0.5 % Константы для построения графов
delx = 3
ymin = -0.5
dely = 3

domains
poi  = xy(real,real)
poiS = poi*
chaS = char*
chaSS= chaS*

database - general
       arc_(char,char,real)     % Дуги графа
       arc_rem(char,char)
determ arc_min(char,char,real)  % Буфер хранания наименьшей дуги
determ arc_max(char,char,real)  % ...............наибольшей....
determ poi_A(chaS)              % Буфер списка вершин
determ arc_len(real)            % Буфер вычисления длины графа
    
database - points       
       point(char,poi)          % Наименования и координаты вершин графа
       
predicates
leng1(char,chaS)
leng (chaS,chaS)
minimum(char,char,real)
opor(char,chaS)
deltop(char,chaS,chaS)
max_arc
max1(char,char,real)
formPoi(char)
arc1(char,char)
sod(char,chaS)
step
step2(char,char,real)
sodrem(char,char)
wri
wrigra(integer,integer)
wrilin(integer,integer,integer)
readsp(char)

clauses
minimum(A,B,L):-              
     arc_min(_,_,L0),
     L < L0,
     retract(arc_min(_,_,L0)),!,
     assert(arc_min(A,B,L)),!;
     !.

leng1(_,[]).                   % Поиск минимальной дуги для вершины А
leng1(A,[H|L]):-
     point(A,xy(X0,Y0)),!,
     point(H,xy(X1,Y1)),!,
     Len=sqrt((X1-X0)*(X1-X0)+(Y1-Y0)*(Y1-Y0)),
     minimum(A,H,Len),
     leng1(A,L),!.

leng([],_).            % Поиск наименьшего расстояния между 
leng([A|T],L):-        % множествами вершин

    leng1(A,L),!,
    leng(T,L),!.

wri:-
    arc_(X,Y,_),
    write("(",X," ",Y,")"),nl,
    fail.
    
%*******************************************************************
% Построение опорного плана
%******************************************************************
opor(_,[]).
opor(A,L):-
    leng1(A,L),
    arc_min(A,B,Len),
    assert(arc_(A,B,Len)),
    assert(arc_rem(A,B)),
    deltop(B,L,LR),
    retract(arc_min(A,_,_)),
    assert(arc_min('0','0',1e77)),
    opor(B,LR),!.

deltop(A,[A|T],R):-R=T,!.
deltop(A,[H|T],R):-
      deltop(A,T,R1),R=[H|R1],!.
      
%**********************************************************************
% Оптимизация опорного плана
%**********************************************************************
max_arc:-
    arc_max(_,_,Lmax),
    arc_(X,Y,Len),
    Len > Lmax,
    max1(X,Y,Len).           % Нахождение самой длинной дуги

max1(X,Y,Len):-
    sodrem(X,Y),
    retract(arc_max(_,_,_)),
    assert(arc_max(X,Y,Len)),
    fail.

sodrem(X,Y):-
   arc_rem(X,Y),!.

formPoi(A):-                 %Построение множества точек связанных 
    arc1(A,B),               % на графе с точкой А   
    poi_A(X),
    not(sod(B,X)),
    retract(poi_A(X)),
    S=[B|X],
    assert(poi_A(S)),
    formPoi(B),!.

arc1(A,B):-
    arc_(A,B,_);
    arc_(B,A,_).

sod(A,[]):-!,fail.
sod(A,[A|L]):-!.
sod(A,[H|L]):- sod(A,L),!.


step:-                    % Перебор дуг опорного графа в порядке
   trace(on),             % уменьшения длины
   arc_(A,B,L),
   step2(A,B,L).


step2(A,B,L):-
   assert(arc_max(A,B,L)),!,
   not(max_arc),              % Выбор самой длинной дуги
   arc_max(Am,Bm,Lmax),
   retract(poi_A(X11)),
   assert(poi_A([Am])),
   retract(arc_(Am,Bm,Lmax)), % Разрезание графа по длинной дуге
   not(formPoi(Am)),          % Построение множества точек связанных
                              % с вершиной Ам     
   poi_A(SA),
   retract(poi_A(X22)),
   assert(poi_A([Bm])),
   not(formPoi(Bm)),          % Построение множ. связанных с Вм
   poi_A(SB),
   retract(arc_min(_,_,_)),
   assert(arc_min('0','0',1e77)),
   leng(SA,SB),               % Формирование наименьшей дуги между 
   trace(on),                 % множ. SA и SB
   arc_min(Amin,Bmin,Lmin),
   retract(arc_max(Amax,Bmax,_)),!,
   assert(arc_(Amin,Bmin,Lmin)),       % Включение в граф новой дуги
   not(retract(arc_rem(Amax,Bmax))),!. % Окончание работ?
%*****************************************************************   
% Визуализация результатов
%*****************************************************************
wrigra(XD,YD):-
   setcolor(0),
   point(A,xy(X,Y)),
   N=trunc(((X-xmin)/delx)*npic)+XD,
   M=trunc(((Y-ymin)/dely)*mpic)+YD,
   N1=N+3,
   M1=M+3,
   circle(N,M,2),
   str_char(A1,A),
   outtextxy(N1,M1,A1),
   fail.
   
 wrilin(XD,YD,Col):-
   setcolor(Col),
   arc_(A,B,L), point(A,xy(X1,Y1)),  point(B,xy(X2,Y2)),
   N1=trunc(((X1-xmin)/delx)*npic)+XD,
   N2=trunc(((X2-xmin)/delx)*npic)+XD,
   M1=trunc(((Y1-ymin)/dely)*mpic)+YD,
   M2=trunc(((Y2-ymin)/dely)*mpic)+YD,
   line(N1,M1,N2,M2),
   retract(arc_len(L1)), L2=L1+L,
   assert(arc_len(L2)),
   fail.
     
 readsp(B):-
   point(A,_),
   A<>B,
   retract(poi_A(S1)),
   S2=[A|S1],
   assert(poi_A(S2)),
   fail.  




%**********************************
goal
trace(on),
assert(poi_A([])),
consult("point.bd",points),
assert(arc_len(0.0)),
assert(arc_min('0','0',1e77)),

point(AA,_),
not(readsp(AA)),
poi_A(SP0),
opor(AA,SP0),
Initialize,
colorpie(C1,_,C3,_),
fillpoly([1,1, 1,500, 500,500, 500,1]),
%opor('a',['b','c','d','e','f','g','h','l']),
not(wrigra(0,0)),
not(wrilin(0,0,0)),
outtextxy(300,100,"Опорный план. Длина =" ),
retract(arc_len(LL1)),
str_real(S1,LL1),
outtextxy(330,120,S1),
step,
not(wrigra(0,200)),
assert(arc_len(0.0)),
not(wrilin(0,200,9)),
outtextxy(300,300,"Оптимальный план. Длина " ),
retract(arc_len(LL2)),
str_real(S2,LL2),
outtextxy(330,320,S2),
readchar(XXX).






