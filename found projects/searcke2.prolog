%trace widen
%do1 DOIT issolut do1
%Start1 contain after compClrcentr sc conv
% evrsearch widen
%Поиск с предпочтением
%Данные считываются с клавиатуры (с контролем ввода)
%начальное и конечное положение, есть возможность повторения

Domains
  charlist=char*
  coord=integer*.
  point=coord*.
  Tree=tree(point,integer,integer,trees);leaf(point,integer,integer).
  trees=tree*.
  points=point*.
  ind=yes;no;never.
  adopt=adopt(point,integer).
  adopts=adopt*.
  ints=integer*.

predicates
  evrsearch(point,points).
  widen(points,tree,integer,tree,ind,points).
  continue(points,tree,integer,tree,ind,ind,points).
  foster_list(integer,adopts,trees).
  insert(tree,trees,trees).
  f(tree,integer).
  opt_f(trees,integer).
  min(integer,integer,integer).
  max_f(integer).
  aim(point).
  bagof(point,points,adopts,adopts).
  h(point,integer).
  after(point,point,integer).
  belong(adopt,adopts,integer).
  belong(point,points,integer).
  belong(integer,ints,integer).
  belong(coord,point,integer).
  move(coord,coord,point,point).
  distance(coord,coord,integer).
  sumdistance(point,point,integer).
  regulate(point,integer).
  regulate(point,coord,integer).
  score(coord,coord,integer).
  showsol(points).
  showpos(point).

  char_int_(charlist,coord,coord,integer).
  convert(integer,coord,coord).
  do(integer,coord,point,point).
  contains(integer,coord,integer,integer).
  contain(coord,point,integer,integer).
  c(point,integer,coord).
  string_chlist(string,charlist).
  hello(point,point).
  Start.
  Ex(char).
  St(char).
  Start1(point,point,integer).
  Clrcentr(integer,point,point).
  sc(point,point,coord,point).
  conv(point,point,point).
  Comp(coord).
  doit(point,integer,point,integer).
  do1(point,integer,point,integer).
  Issolut(point,integer,point,integer,integer).
 Chek(integer,point).

Goal

  St('y').

Clauses

  Comp(H):- H=[1,3];
         H=[3,3];
         H=[1,1];
         H=[3,1].

  Start1([H|T],Sol,J):- H=[2,2], Sol=[H|T];Comp(H), after([H|T],W,C),
         Start1(W,Sol,J);
         contain([2,2],[H|T],0,J), Sol=[H|T].

  Clrcentr(J,[H|T],Sol1):- Y=H, Sol=[[2,2]], sc(T,Sol,Y,Sol1).

  sc([],Sol,_,Sol).
  sc([H|T],Sol,Y,SS):- H=[2,2], Sol1=[Y|Sol],
         sc(T,Sol1,Y,SS);
         Sol1=[H|Sol], sc(T,Sol1,Y,SS).

  conv([],Res,Res).
  conv([H|S],Res,W):- Res1=[H|Res], Conv(S,Res1,W).

  do1(P,I,[],I).
  do1(P,I,[H|T],Q1):- doit(P,J,T,Count), I1=I+Count, do1(P,I1,T,Q1).

  doit(P,_,[],0).
  doit(P,I,[H|T],Count):- contain(H,P,1,J), Issolut(P,0,T,J,Count).

  Issolut(P,I,[],J,I).
  Issolut(P,I,[H|T],J,A):- contain(H,P,1,K),
         K-J>0,
         Issolut(P,I,T,J,A);
         I1=I+1, Issolut(P,I1,T,J,A).

  Start:-
         hello(Res,AimRes),!,
         Start1(Res,Solution,J),
         Clrcentr(J,Solution,Sol),
         conv(Sol,[],[H|Sol1]),
         L=[[2,2],[1,3],[2,3],[3,3],[3,2],[3,1],[2,1],[1,1],[1,2]],
         do1(Sol1,0,L,Count),!,
         Count1=Count mod 2,
         Chek(Count1,Res).

  Chek(Cnt,Res):- Cnt=0,
         evrsearch(Res,[H1|Solution1]),
         not(H1=[[9,9]]),
         makewindow($1E,$1F,$1E," Решение ",4,29,23,15),
         showsol([H1|Solution1]);
         makewindow($4E,$4F,$4E," Решение ",12,14,6,21), nl,
         write("    Нет решения "), readchar(_).

  Ex(Ch):- makewindow($30,$30,$3F," Выход ",12,14,6,21), nl,
         write("   Повторим? (y)  "), readchar(Ch).

  St(Ch):- Ch='y',Start,
         Ex(Ch1), St(Ch1);
         !.

  char_int_(_,IntList,L,11):- L=IntList. % Вырезаем 11 символов.
  char_int_([H|T],IntList,L,I):- char_int(H,Y1),
         Y=Y1-48, T1=[Y|IntList],
         I1=I+1, char_int_(T,T1,L,I1).

  contains(R,[R|T],I,I). % Проверяем принадлежность элемента R списку [H|T]
  contains(R,[H|T],I,J):- I1=I+1, contains(R,T,I1,J). % и фиксируем его номер.

  contain(R,[R|T],I,I). % Проверяем принадлежность элемента R списку [H|T]
  contain(R,[H|T],I,J):- I1=I+1, contain(R,T,I1,J). % и фиксируем его номер.

  c([H|T],1,H). % По номеру элемента устанавливаем его координаты.
  c([H|T],I,L):- I1=I-1, c(T,I1,L).

  convert(R,E,L):-
         CoordList=[[3,1],[2,1],[1,1],[0,0],[3,2],[2,2],[1,2],[0,0],[3,3],[2,3],[1,3]],
         contains(R,E,1,J), c(CoordList,J,L).

  do(-1,E,Ls,Res):- Res=Ls.
  do(R,E,Ls,Res):- convert(R,E,L), Ls1=[L|Ls],
         R1=R-1, do(R1,E,Ls1,Res).

  string_chlist("",[]).
  string_chlist(S,[H|T]):- frontchar(S,H,S1),
         string_chlist(S1,T).

  hello(Res,AimRes):-
         makewindow($70,$70,$70," Игра в восемь ",2,2,28,45),
         makewindow($1E,$1F,$1E,"начальное положение",4,5,11,22),
         edit("",S),
         string_chlist(S,Charlist),  %Переводим строку в список символов
         char_int_(Charlist,[],E,0), %Переводим список символов в список чисел
         do(8,E,[],Res),             % В цикле список чисел переводим
                                     % в список координат
         makewindow ($1E,$1F,$1E,"конечное положение", 16,5,11,22),
         write("123"),nl,
         write("804"),nl,
         write("765");
         makewindow($4E,$4F,$4E," Ошибка ",12,8,5,35), nl,
         write("  Вы ввели некорректные данные."),
         readchar(_),
         makewindow($70,$70,$70," Игра в восемь ",2,2,28,45),
         makewindow($30,$30,$3F," Выход ",12,14,5,21), nl,
         write("   Повторим? (y)  "),
         readchar(Ch), nl, Ch='y',
         hello(Res1,AimRes1).

  max_f(32767).

  evrsearch(Start,Solution):-
         max_f(Fmax),    % Fmax>любой f-оценки
         widen([],leaf(Start,0,0),Fmax,_,yes,Solution).


  widen(P,leaf(B,_,_),_,_,yes,[B|P]):-
         aim(B).
  widen(P,leaf(B,F,G),Lim,Der1,Issol,Sol):-
         F<=Lim,
         bagof(B,P,Adopted,[]),!,
         foster_list(G,Adopted,DD),
         opt_f(DD,F1),
         widen(P,tree(B,F1,G,DD),Lim,Der1,Issol,Sol);
         Issol=never. % Нет преемников - тупик
  widen(P,tree(B,F,G,[D|DD]),Lim,Der1,Issol,Sol):-
         F<=Lim,
         opt_f(DD,OF),
         min(Lim,OF,Lim1),
         widen([B|P],D,Lim1,D1,Issol1,Sol),
         continue(P,tree(B,F,G,[D1|DD]),Lim,Der1,Issol1,Issol,Sol).
  widen(_,tree(_,_,_,[]),_,_,never,_):- !. % Тупиковое дерево - нет решений
  widen(_,Der,Lim,Der,no,_):-
         f(Der,F),
         F>Lim. % Рост остановлен


  continue(_,_,_,_,yes,yes,Sol).
  continue(P,tree(B,F,G,[D1|DD]),Lim,Der1,no,Issol,Sol):-
         insert(D1,DD,HDD),
         opt_f(HDD,F1),
         widen(P,tree(B,F1,G,HDD),Lim,Der1,Issol,Sol).
  continue(P,tree(B,F,G,[D1|DD]),Lim,Der1,never,Issol,Sol):-
         Issol1=never,
         HDD=DD,
         opt_f(HDD,F1),
         widen(P,tree(B,F1,G,HDD),Lim,Der1,Issol,Sol).

  foster_list(_,[],[]).
  foster_list(G0,[adopt(B,C)|BB],DD):-
         G=G0+C,
         h(B,H),                 % Эвристика h(B)
         F=G+H,
         foster_list(G0,BB,DD1),
         insert(leaf(B,F,G),DD1,DD).

  % Вставка дерева Д в список деревьев ДД с сохранением
  % упорядочности по f-оценкам
  insert(D,DD,[D|DD]):-
         f(D,F),
         opt_f(DD,F1),
         F<=F1,!.
  insert(D,[D1|DD],[D1|DD1]):-
         insert(D,DD,DD1).

  % Получение f-оценок
  f(leaf(_,F,_),F).
  f(tree(_,F,_,_),F).

  opt_f([D|_],F):- f(D,F).
  opt_f([],Fmax):- max_f(Fmax).

  min(X,Y,X):- X<=Y,!.
  min(X,Y,Y).

  aim([[2,2],[1,3],[2,3],[3,3],[3,2],[3,1],[2,1],[1,1],[1,2]]).

  bagof(B,P,AN,A):-
         after(B,B1,C),
         not(belong(B1,P,_)),
         not(belong(adopt(B1,C),A,_)),
         bagof(B,P,AN,[adopt(B1,C)|A]),!.
  bagof(B,P,A,A).

  belong(B,[B|_],1).
  belong(B,[H|P],N):- belong(B,P,N1), N=N1+1.

  after([Vacant|List],[Piece|List1],1):-
         % Стоимость всех дуг равны 1
         move(Vacant,Piece,List,List1).
         % Переставив Пусто (Vacant) и Piece получаем  List1

  move(P,F,[F|C],[P|C]):- distance(P,F,1).
  move(P,F,[F1|C],[F1|C1]):- move(P,F,C,C1).

  distance([X,Y],[X1,Y1],P):-
  % Манхеттеновское рассстояние между клетками
         X2=X, X3=X1,
         Y2=Y, Y3=Y1,
         P=abs(X-X1)+abs(Y-Y1).

  % Эвристическая оценка h равна сумме расстояний фишек
  % от их "целевых" клеток плюс "степень упорядоченности",
  % умноженнная на 3
  h([Vacant|List],H):-
         aim([Vacant1|AList]),
         Sumdistance(List,AList,P),
         regulate(List,Reg),
         H=P+3*Reg.

  Sumdistance([],[],0).
  Sumdistance([F|C],[F1|C1],P):-
         distance(F,F1,P1),
         Sumdistance(C,C1,P2),
         P=P1+P2.

  regulate([First|C],Reg):-
         regulate([First|C],First,Reg).
  regulate([F1,F2|C],First,Reg):-
         score(F1,F2,Reg1),
         regulate([F2|C],First,Reg2),
         Reg=Reg1+Reg2.
  regulate([Last],First,Reg):-
         score(Last,First,Reg).

  score([2,2],_,1):-!.      %Фишки в центре - 1 очко
  score([1,3],[2,3],0):-!.  % Правильная последовательность
  score([2,3],[3,3],0):-!.
  score([3,3],[3,2],0):-!.
  score([3,2],[3,1],0):-!.
  score([3,1],[2,1],0):-!.
  score([2,1],[1,1],0):-!.
  score([1,1],[1,2],0):-!.
  score([1,2],[1,3],0):-!.
  score(_,_,2):-!.          %Неправильная последовательность

  % Отображение решающего пути в виде списка позиций на доске
  showsol([]).
  showsol([Pos|List]):-
         showsol(List),
         nl, write("---"),
         showpos(Pos),
         ReadChar(_).

  % Отображение позиции на доске
  showpos(Pos):-
         belong(Y,[3,2,1],_),      % Порядок Y-координат
         nl, belong(X,[1,2,3],_),  % Порядок X-координат
         belong([X,Y],Pos,N),
         N1=N-1,
         write(N1),
         fail.      % Возврат с переходом к следущей клетке
  showpos(_).
