
% Программист: Садовский Б. С.
% Программа:
% доказательство простых теорем на основе принципа резолюции!
%
% В качестве примера представлено выражение:
% (~a v b) & (~b v c) & a & ~c
% находящиеся в коньюнктивной нормальной форме.
% 02.06.2005


% Шаг резолюции состоит из дейстий:
% 1. Если существуют два таких дизъюнкта D1 и D2,
% 2. что P является подвыражением D1,
% 3. а ~P подвыражением D2
% 4. то удалить P из D1 получим CA
% 5. ~P из D2 получим CB
% 6. склеить результат в CA v CB.

domains

	n_list = symbol *  % создание списка

predicates

	start
	del(n_list, n_list, n_list)
	add(n_list, n_list, n_list)
	concatenat(n_list, n_list, n_list)
	divide(n_list, n_list, n_list, n_list)
	compare(n_list, n_list)
	sub_compare(symbol, n_list)
	sub_compare_2(n_list, n_list)
	end(n_list)
	step(n_list, n_list, n_list)

database

	disjunct(n_list)  % Дизъюнкт

clauses

/* Исходные данные (Факты) */

	disjunct(["~", a, "v", b]).  % загрузка первого дизъюнкта
	disjunct(["~", b, "v", c]).  % второго
	disjunct([a]).               % третьего
	disjunct(["~", c]).          % четвёртого

/* Правила */

% Запуск программы

	start:-
		disjunct(C1),
		retract(disjunct(C1)),
		nl, nl, write("C1=",C1),
		disjunct(C2),
		retract(disjunct(C2)),
		nl, write("C2=",C2), nl,
		step(C1, C2, C1vC2),
		not(end(C1vC2)),
		asserta(disjunct(C1vC2)),
		start.

/* На вход step() подаются дизъюнкты С1 и С2 далее
   если возможно они делятся на под выражения
   сопоставляются и если являются подвыражениями
   вида (~P и P) то возврасщается пустой список
   через CAvCB в противном случае возврасщается
   склеенный дизъюнкт CAvCB */
	step(C1, C2, CAvCB):-
                % разбиваем список С1 на
                % списки C1L и (_)(место C1R)
                divide(C1, C1L, ["v"], _),
                % тоже самое для второго списка
		divide(C2, C2L, ["v"], _),
                % далее сопоставляем подвыражения
                compare(C1L, C2L),
                % далее удаляем подвыражение P из С2
                % и ~P из С1
                del(C1L, C2, CB), del(C2L, C1, CA),
		% склеиваем списки полученные
                % после удаления из них P и ~P
		concatenat(CA, CB, CAvCB), !.
		% Список CAvCB будет получен
		% только если все правила
                % будут выполнены!
                % Рассматривать следующие правила
                % шага резольции не будем
                % потому, что они работают также!
                % Каждое из 8-и вариантов шага резолюции
                % step разбирает только свой тип
                % дизъюнкта.
                % Пример для текущего правила: (~a v b)
	step(C1, C2, CAvCB):-
		divide(C1, C1L, ["v"], _),
		divide(C2, C2L, ["v"], C2R),
		compare(C1L, C2R),
		del(C1L, C2, CB), del(C2L, C1, CA),
		concatenat(CA, CB, CAvCB), !.
	step(C1, C2, CAvCB):-
		divide(C1, _, ["v"], C1R),
		divide(C2, C2L, ["v"], _),
		compare(C1R, C2L),
		del(C1R, C2, CB), del(C2L, C1, CA),
		concatenat(CA, CB, CAvCB), !.
	step(C1, C2, CAvCB):-
		divide(C1, _, ["v"], C1R),
		divide(C2, _, ["v"], C2R),
		compare(C1R, C2R),
		del(C1R, C2, CB), del(C2R, C1, CA),
		concatenat(CA, CB, CAvCB), !.
	step(C1, C2, CAvCB):-
		divide(C1, C1L, ["v"], _),
		compare(C2, C1L),
		del(C2 ,C1, CA),
		CAvCB = CA, !.
	step(C1, C2, CAvCB):-
		divide(C1, _, ["v"], C1R),
		compare(C2, C1R),
		del(C2, C1, CA),
		CAvCB = CA, !.
	step(C1, C2, CAvCB):-
		divide(C2, C2L, ["v"], _),
		compare(C1, C2L),
		del(C1, C2, CA),
		CAvCB = CA, !.
	step(C1, C2, CAvCB):-
		divide(C2, _, ["v"], C2R),
		compare(C1, C2R),
		del(C1, C2, CA),
		CAvCB = CA, !.

	step(C1, C2, CAvCB):-
		compare(C1, C2),
		CAvCB = [].

/* Добавление элемента L1 в список L3 через L2,
   либо соединение двух списков L1 и L2 в список L3*/
	add([], L, L).
	add([Head | L1], L2, [Head | L3]):-
		add(L1, L2, L3).

/* Удаление элемента P из списка С если P с лево*/
	del(P, C, CA):-
		divide(C, LL, ["v"], LR),
		compare(P, LL),
		CA = LR.
/* Удаление элемента P из списка C если P с право */
	del(P, C, CA):-
		divide(C, LL, ["v"], LR),
		compare(P, LR),
		CA = LL.

/* Деление списка L на части через делитель.
   Если какой либо из переменных задать конкретное
   значение то список будет разбит на части
   L1 L2 L3 в зависимости от того, какой из этих
   переменных задано значение */
	divide(L, L1, L2, L3):-
		add(L1, T,  L),
		add(L2, L3, T).

/* Соединение двух списков */
	concatenat(CA, CB, CAvCB):-
		add(["v"], CB, CACB),
		add(CA, CACB, CAvCB).

/* Проверка на отношение элементов S1 к S2
   если S1 отрицаемо */
	compare(S1, S2):-
		sub_compare("~",  S1),
		sub_compare_2(S2, S1).

/* Проверка на отношение элементов S1 к S2
   если S2 отрицаемо */
	compare(S1, S2):-
		sub_compare("~",  S2),
		sub_compare_2(S1, S2).

/* Проверка головы на "~" */
	sub_compare(Head, [Head | _]).
/* Проверка хвоста на "~" */
	sub_compare_2(Tail, [_ | Tail]).


/* Если список пуст значит есть противоречие */
	end([]):-
		write("Обнаружено противоречие!"), nl.

