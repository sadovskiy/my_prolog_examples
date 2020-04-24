%                        ���� ��⮤�
%
%   �� �᭮�� ��������� ������⢠ �祪 ���設 ��� ��ந��� ���୮� �襭��
% �।�⠢���饥 ᮡ�� ������� �易��� ���.
%   ������⢮ �祪 ���設 ��� �࠭���� � 䠩�� "point.bd" � ���� ��������
% ⨯�:      point(<��� ���設�>,xy(<���न��� X>,<���न��� Y>)), ।������ 
% 䠩� ����� �������� �������� ��� (��䨪� ����஥�� �� ���ᠭ�� �������� 
% ��� � �����筮� ������).
%   ��� ����஥��� ���୮�� �襭�� �ᯮ������ ᫥���騩 ������:
% 1. �롨ࠥ��� �ந����쭠� �窠 ������⢠ �.
% 2. � ��� ��ᮥ������� �������� �窠 � � ⥬ ᠬ� �ନ����� ॡ�
%    (�,�).
% 3. � �窥 � ��ᮥ������� ᫥����� �������� �窠 � �.�.
%   ����஥��� �易��� ��� �� ��易⥫쭮 �������� ᢮��⢮� ��⨬��쭮��
% ������ ���, ���⮬� ����室��� ��������஢��� ���୮� �襭��.
%   ��� �⮣� � ����஥���� ��� ����� ᠬ�� ������� ॡ� � �� �⮬� ॡ��
% ��� ࠧ१����� �� ��� ���. � ᮮ⢥��⢨� � 2 ����祭�묨 �����䠬�
% �ନ������ ��� ������⢠ �祪 (���設 ��䮢), ࠭�� �易���� ����� ᮡ��
% 㤠����� ॡ஬. ����� ����஥��묨 ������⢠�� ����� ॡ� (��� �窨)
% �������襩 �����. ����� 㤠������ ��� (ॡ�) ��������� �� ����� ॡ�.
% �᫨ ����� ������ ॡ� ����� 祬 ����� ��ண� ॡ�, � �㬬�ୠ� �����
% ��� �㤥� �����.����� ��楤�� �த��뢠���� � �ᥬ� ॡࠬ� ���୮��
% �襭��.
%  ����� ��������, �� �।������� ������ �⮨� ��������� �易��� ���.
%  ��� ���㠫���樨 १���⮢ �ᯮ������� �� ��� �ணࠬ�� RULET.PRO �
% GRAPDEC.PRO � ������ ॠ�������� ����ன�� �ணࠬ� BGI-��䨪�.
% �ணࠬ�� �����⢮���� �� �ਬ�஢ �몠 ������ 2.0.    

%trace
% wrigra
include "rulet.pro"

CONSTANTS
npic = 500
mpic = 500
xmin = -0.5 % ����⠭�� ��� ����஥��� ��䮢
delx = 3
ymin = -0.5
dely = 3

domains
poi  = xy(real,real)
poiS = poi*
chaS = char*
chaSS= chaS*

database - general
       arc_(char,char,real)     % �㣨 ���
       arc_rem(char,char)
determ arc_min(char,char,real)  % ���� �࠭���� �������襩 �㣨
determ arc_max(char,char,real)  % ...............�������襩....
determ poi_A(chaS)              % ���� ᯨ᪠ ���設
determ arc_len(real)            % ���� ���᫥��� ����� ���
    
database - points       
       point(char,poi)          % ������������ � ���न���� ���設 ���
       
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

leng1(_,[]).                   % ���� �������쭮� �㣨 ��� ���設� �
leng1(A,[H|L]):-
     point(A,xy(X0,Y0)),!,
     point(H,xy(X1,Y1)),!,
     Len=sqrt((X1-X0)*(X1-X0)+(Y1-Y0)*(Y1-Y0)),
     minimum(A,H,Len),
     leng1(A,L),!.

leng([],_).            % ���� �������襣� ����ﭨ� ����� 
leng([A|T],L):-        % ������⢠�� ���設

    leng1(A,L),!,
    leng(T,L),!.

wri:-
    arc_(X,Y,_),
    write("(",X," ",Y,")"),nl,
    fail.
    
%*******************************************************************
% ����஥��� ���୮�� �����
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
% ��⨬����� ���୮�� �����
%**********************************************************************
max_arc:-
    arc_max(_,_,Lmax),
    arc_(X,Y,Len),
    Len > Lmax,
    max1(X,Y,Len).           % ��宦����� ᠬ�� ������� �㣨

max1(X,Y,Len):-
    sodrem(X,Y),
    retract(arc_max(_,_,_)),
    assert(arc_max(X,Y,Len)),
    fail.

sodrem(X,Y):-
   arc_rem(X,Y),!.

formPoi(A):-                 %����஥��� ������⢠ �祪 �易���� 
    arc1(A,B),               % �� ��� � �窮� �   
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


step:-                    % ��ॡ�� �� ���୮�� ��� � ���浪�
   trace(on),             % 㬥��襭�� �����
   arc_(A,B,L),
   step2(A,B,L).


step2(A,B,L):-
   assert(arc_max(A,B,L)),!,
   not(max_arc),              % �롮� ᠬ�� ������� �㣨
   arc_max(Am,Bm,Lmax),
   retract(poi_A(X11)),
   assert(poi_A([Am])),
   retract(arc_(Am,Bm,Lmax)), % ���१���� ��� �� ������� �㣥
   not(formPoi(Am)),          % ����஥��� ������⢠ �祪 �易����
                              % � ���設�� ��     
   poi_A(SA),
   retract(poi_A(X22)),
   assert(poi_A([Bm])),
   not(formPoi(Bm)),          % ����஥��� ����. �易���� � ��
   poi_A(SB),
   retract(arc_min(_,_,_)),
   assert(arc_min('0','0',1e77)),
   leng(SA,SB),               % ��ନ஢���� �������襩 �㣨 ����� 
   trace(on),                 % ����. SA � SB
   arc_min(Amin,Bmin,Lmin),
   retract(arc_max(Amax,Bmax,_)),!,
   assert(arc_(Amin,Bmin,Lmin)),       % ����祭�� � ��� ����� �㣨
   not(retract(arc_rem(Amax,Bmax))),!. % ����砭�� ࠡ��?
%*****************************************************************   
% ���㠫����� १���⮢
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
outtextxy(300,100,"����� ����. ����� =" ),
retract(arc_len(LL1)),
str_real(S1,LL1),
outtextxy(330,120,S1),
step,
not(wrigra(0,200)),
assert(arc_len(0.0)),
not(wrilin(0,200,9)),
outtextxy(300,300,"��⨬���� ����. ����� " ),
retract(arc_len(LL2)),
str_real(S2,LL2),
outtextxy(330,320,S2),
readchar(XXX).






