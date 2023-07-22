% 1.
% a. Sort a list with removing the double values. E.g.: [4 2 6 2 3 4] --> [2 3 4 6]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% write a predicate to sort every sublist with removing the doubles.
% Eg.: [1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7].

% a

% Model matematic:
% my_length(l1...ln, c) =
% 	c, n = 0
% 	my_length(l2...ln, c + 1), otherwise

% my_length(L:list, C:number, R:number)
% flow model: my_length(i, i, o)

my_length([], C, C).
my_length([_|T], C, R) :-
    NC is C + 1,
    my_length(T, NC, R).

% Model matematic:
% merge_sort(l1...ln) =
% 	[], n = o
% 	[l1], n = 1
% 	merge( merge_sort(l1....l(n/2)), merge_sort(l(n/2+1)...ln)), otherwise

% merge_sort(L:list, R:list)
% flow model: merge_sort(i, o)

merge_sort([], []).
merge_sort([E], [E]).
merge_sort(L, R) :-
    split(L, Left, Right),
    merge_sort(Left, RL),
    merge_sort(Right, RR),
    my_merge(RL, RR, R).

% Model matematic:
% split(l1...ln, c1...cm) =
% 	return, abs(m - n) <= 1 -> ori 1 ori 0 altfel merge in apel recursiv
% 	split(l2...ln, l1 + c1...cm), n > m

% split(L:list, LC:list, Left:list, Right:list)
% flow model: split(i, i, o, o)

split(L, LC, LC, L) :-
    my_length(L, 0, RL),
    my_length(LC, 0, RLC),
    Diff is RLC - RL,
    abs(Diff, AUX),
    AUX =< 1.
split([H|T], LC, Left, Right) :-
    my_append(LC, H, RA),
    split(T, RA, Left, Right).

% split(L:list, Left:list, Right:list)
% flow model: split(i, o, o)
split(L, Left, Right) :- split(L, [], Left, Right).

% Model matematic:
% my_append(l1...ln, e) =
% 	[e], n = 0
% 	l1 + my_append(l2...ln, e), otherwise

% my_append(L:list, E:number, R:list)
% flow model: my_append(i, i, o)

my_append([], E, [E]).
my_append([H|T], E, [H|R]) :-
    my_append(T, E, R).

% Model matematic:
% my_merge(l1...ln, r1...rm) =
% 	l1...ln, m = 0
% 	r1...rn, n = 0
% 	l1 + my_merge(l2...ln, r1...rm), l1 <= r1
% 	r1 + my_merge(l1...ln, r2...rm), l1 > r1

% my_merge(L:list, R:list, R:list)
% flow model: my_merge(i, i, o)
my_merge(L, [], L).
my_merge([], R, R).
my_merge([HL|TL], [HR|TR], [HL|R]) :- HL =< HR,
    my_merge(TL, [HR|TR], R).
my_merge([HL|TL], [HR|TR], [HR|R]) :- HL > HR,
    my_merge([HL|TL], TR, R).

% Model matematic:
% remove_doubles(l1...ln) =
% 	[], n = 0
% 	[l1], n = 1
% 	l1 + remove_doubles(l2...ln), l1 != l2
% 	remove_doubles(l2...ln), otherwise

% remove_doubles(L:list, R:list)
% flow model: remove_doubles(i, o)

remove_doubles([], []).
remove_doubles([E], [E]).
remove_doubles([H1, H2|T], [H1|R]) :- H1 =\= H2,
    remove_doubles([H2|T], R).
remove_doubles([H1, H2|T], R) :- H1 =:= H2,
    remove_doubles([H2|T], R).

% sort_list(L:list, R:list)
% flow model: sort_list(i, o)

sort_list(L, R) :-
    merge_sort(L, RS),
    remove_doubles(RS, R).

% b

% Model matematic:
% heterList(l1...ln) = 
% 	[], n = 0
% 	sort_list(l1) + heterList(l2...ln), is_list(l1) = True
% 	l1 + heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([H|T], [HR|R]) :- is_list(H), !,
    sort_list(H, HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).



% 2.
% a. Sort a list with keeping double values in resulted list. 
% E.g.: [4 2 6 2 3 4] --> [2 2 3 4 4 6]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% write a predicate to sort every sublist, keeping the doubles.
% Eg.: [1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, 2, [1, 4, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1, 1, 1], 7].

% a

% Model matematic:
% my_length(l1...ln, c) =
% 	c, n = 0
% 	my_length(l2...ln, c + 1), otherwise

% my_length(L:list, C:number, R:number)
% flow model: my_length(i, i, o)

my_length([], C, C).
my_length([_|T], C, R) :-
    NC is C + 1,
    my_length(T, NC, R).

% Model matematic:
% merge_sort(l1...ln) =
% 	[], n = o
% 	[l1], n = 1
% 	merge( merge_sort(l1....l(n/2)), merge_sort(l(n/2+1)...ln)), otherwise

% merge_sort(L:list, R:list)
% flow model: merge_sort(i, o)

merge_sort([], []).
merge_sort([E], [E]).
merge_sort(L, R) :-
    split(L, Left, Right),
    merge_sort(Left, RL),
    merge_sort(Right, RR),
    my_merge(RL, RR, R).

% Model matematic:
% split(l1...ln, c1...cm) =
% 	return, abs(m - n) <= 1 -> ori 1 ori 0 altfel merge in apel recursiv
% 	split(l2...ln, l1 + c1...cm), n > m

% split(L:list, LC:list, Left:list, Right:list)
% flow model: split(i, i, o, o)

split(L, LC, LC, L) :-
    my_length(L, 0, RL),
    my_length(LC, 0, RLC),
    Diff is RLC - RL,
    abs(Diff, AUX),
    AUX =< 1.
split([H|T], LC, Left, Right) :-
    my_append(LC, H, RA),
    split(T, RA, Left, Right).

% split(L:list, Left:list, Right:list)
% flow model: split(i, o, o)
split(L, Left, Right) :- split(L, [], Left, Right).

% Model matematic:
% my_append(l1...ln, e) =
% 	[e], n = 0
% 	l1 + my_append(l2...ln, e), otherwise

% my_append(L:list, E:number, R:list)
% flow model: my_append(i, i, o)

my_append([], E, [E]).
my_append([H|T], E, [H|R]) :-
    my_append(T, E, R).

% Model matematic:
% my_merge(l1...ln, r1...rm) =
% 	l1...ln, m = 0
% 	r1...rn, n = 0
% 	l1 + my_merge(l2...ln, r1...rm), l1 <= r1
% 	r1 + my_merge(l1...ln, r2...rm), l1 > r1

% my_merge(L:list, R:list, R:list)
% flow model: my_merge(i, i, o)
my_merge(L, [], L).
my_merge([], R, R).
my_merge([HL|TL], [HR|TR], [HL|R]) :- HL =< HR,
    my_merge(TL, [HR|TR], R).
my_merge([HL|TL], [HR|TR], [HR|R]) :- HL > HR,
    my_merge([HL|TL], TR, R).

% sort_list(L:list, R:list)
% flow model: sort_list(i, o)

sort_list(L, R) :-
    merge_sort(L, R).

% b

% Model matematic:
% heterList(l1...ln) = 
% 	[], n = 0
% 	sort_list(l1) + heterList(l2...ln), is_list(l1) = True
% 	l1 + heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([H|T], [HR|R]) :- is_list(H), !,
    sort_list(H, HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).




% 3.
% a. Merge two sorted lists with removing the double values.
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% merge all sublists with removing the double values.
% [1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8] =>
% [1, 2, 3, 4, 6, 7, 9, 10, 11]

% a

% Model matematic:
% my_merge(l1...ln, r1...rm) =
% 	l1...ln, m = 0
% 	r1...rn, n = 0
% 	l1 + my_merge(l2...ln, r1...rm), l1 < r1
% 	r1 + my_merge(l1...ln, r2...rm), l1 > r1
% 	my_merge(l1...ln, r2...rm), l1 = r1

% my_merge(L:list, R:list, R:list)
% flow model: my_merge(i, i, o)
my_merge(L, [], L).
my_merge([], R, R).
my_merge([HL|TL], [HR|TR], [HL|R]) :- HL < HR,
    my_merge(TL, [HR|TR], R).
my_merge([HL|TL], [HR|TR], [HR|R]) :- HL > HR,
    my_merge([HL|TL], TR, R).
my_merge([HL|TL], [HR|TR], R) :- HL = HR,
    my_merge([HL|TL], TR, R).

% b

% Model matematic:
% heterList(l1...ln) = 
% 	[], n = 0
% 	merge(l1, heterList(l2...ln)), is_list(l1) = True
% 	heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([H|T], R) :- is_list(H), !,
    heterList(T, RH),
    my_merge(H, RH, R).
heterList([_|T], R) :-
    heterList(T, R).



% 4.
% a. Write a predicate to determine the sum of two numbers written in list representation.
% b. For a heterogeneous list, formed from integer numbers and list of digits, 
% write a predicate to compute the sum of all numbers represented as sublists.
% Eg.: [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] => [8, 2, 2].

% a

% Model matematic:
% my_append(l1...ln, e) =
% 	[e], n = 0
% 	l1 + my_append(l2...ln), otherwise

% my_append(L:list, E:number, R:list)
% flow model: my_append(i, i, o)

my_append([], E, [E]).
my_append([H|T], E, [H|R]) :-
    my_append(T, E, R).

% Model matematic:
% my_length(l1...ln) =
% 	0, n = 0
% 	1 + my_length(l2...ln), otherwise

% my_length(L:list, R:number)
% flow model: my_length(i, o)

my_length([], 0).
my_length([_|T], R) :-
    my_length(T, RC),
    R is RC + 1.

% Model matematic:
% inv_list(l1...ln) =
% 	[], n = 0
% 	my_append(inv_list(l2...ln), l1), otherwise

% inv_list(L:list, R:list)
% flow model: inv_list(i, o)

inv_list([], []).
inv_list([H|T], R) :-
    inv_list(T, RI),
    my_append(RI, H, R).

% Model matematic:
% sum_lists(a1...an, b1...bm) =
% 	a1...an, m = 0
% 	b1...bm, n = 0
% 	inv_list(suma(inv_list(a1...an), inv_list(b1...bm), 0)), n <= m
% 	inv_list(suma(inv_list(b1...bm), inv_list(a1...an), 0)), otherwise

% sum_lists(A:list, B:list, R:list)
% flow model: sum_lists(i, i, o)
sum_lists(A, [], A).
sum_lists([], B, B).
sum_lists(A, B, R) :-
    my_length(A, LA),
    my_length(B, LB),
    LA =< LB, !,
    inv_list(A, RA),
    inv_list(B, RB),
    suma(RA, RB, 0, RS),
    inv_list(RS, R).
sum_lists(A, B, R) :-
    inv_list(A, RA),
    inv_list(B, RB),
    suma(RB, RA, 0, RS),
    inv_list(RS, R).

% Model matematic:
% suma(a1...an, b1...bm, c) =
% 	[], n = 0 and m = 0 and c = 0
% 	[1], n = 0 and m = 0 and c = 1
% 	(b1 + c) + suma([], b2...bm, 0), n = 0 and b1 + c < 10
% 	((b1 + c) % 10) + suma([], b2...bm, 1), n = 0 and b1 + c > 10
% 	(a1 + b1 + c) + suma(a2...an, b2...bm, 0), a1 + b1 + c < 10
% 	((a1 + b1 + c) % 10) + suma(a2...an, b2...bm, 1), a1 + b1 + c > 10

suma([], [], 0, []).
suma([], [], 1, [1]).
suma([], [HB|TB], C, [HBC|R]) :-
    HBC is (HB + C) mod 10, 
    HBC - HB - C =:= 0,
    suma([], TB, 0, R).
suma([], [HB|TB], C, [HBC|R]) :-
    HBC is (HB + C) mod 10, 
    HBC - HB - C =\= 0,
    suma([], TB, 1, R).
suma([HA|TA], [HB|TB], C, [HR|R]) :-
    HR is (HA + HB + C) mod 10,
    HR - HA - HB - C =:= 0,
    suma(TA, TB, 0, R).
suma([HA|TA], [HB|TB], C, [HR|R]) :-
    HR is (HA + HB + C) mod 10,
    HR - HA - HB - C =\= 0,
    suma(TA, TB, 1, R).

% b

% Model matematic:
% heterList(l1...ln) = 
% 	[], n = 0
% 	sum_lists(l1, heterList(l2...ln)), is_list(l1) = True
% 	heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([H|T], R) :- is_list(H), !,
    heterList(T, RH),
    sum_lists(H, RH, R).
heterList([_|T], R) :-
    heterList(T, R).


% 5.
% a. Substitute all occurrences of an element of a list with all the elements of another list.
% Eg. subst([1,2,1,3,1,4],1,[10,11],X) produces X=[10,11,2,10,11,3,10,11,4].
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% replace in every sublist all occurrences of the first element from sublist it a new given list.
% Eg.: [1, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] si [11, 11] =>
% [1, [11, 11, 1, 11, 11], 3, 6, [11, 11, 10, 1, 3, 9], 5, [11 11 11 11 11 11], 7]

% a

% Model matematic:
% inserare(l1...ln, list) =
% 	list, n = 0
% 	l1 + inserare(l2...ln, list), otherwise
 
% inserare(L:list, List:list, R:list)
% inserare(i, i, o)

inserare([], L, L).
inserare([H|T], L, [H|R]) :- inserare(T, L, R).

% Model matematic:
% substitue_elem(l1...ln, e, list) =
% 	[], n = 0
% 	substitue_elem(inserare(list, l2...ln), e, list), l1 = e
% 	l1 + substitue_elem(l2...ln, e, list), l1 != e

% substitue_elem(L:list, E:number, List:list, R:list)
% substitue_elem(i, i, i, o)

substitue_elem([], _, _, []).
substitue_elem([H|T], E, List, R) :- H =:= E,
    inserare(List, T, RI),
    substitue_elem(RI, E, List, R).
substitue_elem([H|T], E, List, [H|R]) :- H =\= E,
    substitue_elem(T, E, List, R).

% b

% Model matematic:
% heterList(l1...ln, list) = 
% 	[], n = 0
% 	substitute_elem(l'1...l'm, l'1, list), heterList(l2...ln), is_list(l1) = True, where l1 = l'1...l'm
% 	l1 + heterList(l2...ln), number(l1) = True

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], _, []).
heterList([[H|HT]|T], E, [HR|R]) :- 
    substitue_elem([H|HT], H, E, HR),
    heterList(T, E, R).
heterList([H|T], E, [H|R]) :- number(H),
    heterList(T, E, R).


% 6.
% a. Determine the product of a number represented as digits in a list to a given digit.
% Eg.: [1 9 3 5 9 9] * 2 => [3 8 7 1 9 8]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% write a predicate to replace every sublist with the position of the maximum element from that sublist.
% [1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]

% a

% Model matematic:
% my_append(l1...ln, e) =
% 	[e], n = 0
% 	l1 + my_append(l2...ln), otherwise

% my_append(L:list, E:number, R:list)
% flow model: my_append(i, i, o)

my_append([], E, [E]).
my_append([H|T], E, [H|R]) :-
    my_append(T, E, R).

% Model matematic:
% inv_list(l1...ln) =
% 	[], n = 0
% 	my_append(inv_list(l2...ln), l1), otherwise

% inv_list(L:list, R:list)
% flow model: inv_list(i, o)

inv_list([], []).
inv_list([H|T], R) :-
    inv_list(T, RI),
    my_append(RI, H, R).

% Model matematic:
% product(l1...ln, e, c) =
% 	[c], n = 0
% 	((l1*e + c) % 10) + product(l2...ln, e, ((l1*e + c)/10)), otherwise

% product(L:list, E:number, C:number, R:list)
% flow model: product(i, i, i, o)

product([], _, 0, []).
product([], _, C, [C]) :- C =\= 0.
product([H|T], E, C, [HR|R]) :-
    HR is (H * E + C) mod 10,
    NC is (H * E + C - HR) / 10,
    product(T, E, NC, R).

% product_list(L:list, E:number, R:list)
% flow model: product_list(i, i, o)

product_list(L, E, R) :- 
    inv_list(L, LI),
    product(LI, E, 0, RP),
    inv_list(RP, R).

% b

% Model matematic:
% maxim_number(a, b) = 
% 	a, a >= b
% 	b a < b

% maxim_number(A:number, B:number, R:number)
% maxim_number(i, i, o)

maxim_number(A, B, A) :- A >= B.
maxim_number(A, B, B) :- A < B.

% Model matematic:
% maxim_list(l1...ln) =
% 	l1, n = 1
% 	maxim_number(l1, maxim_list(l2...ln))
	
% maxim_list(L:list, R:number)
% maxim_list(i, o)

maxim_list([H], H).
maxim_list([H|T], R) :- 
    maxim_list(T, RM),
    maxim_number(H, RM, R).

% Model matematic:
% replace_pos(l1...ln, e, pos) =
% 	[], n = 0
% 	pos + replace_pos(l2...ln, e, pos + 1), l1 = e
%   replace_pos(l2...ln, e, pos + 1), l1 != e	

% replace_pos(L:list, E:number, Pos:number, R:list)
% flow model: replace_pos(i, i, i, o)

replace_pos([], _, _, []).
replace_pos([H|T], E, Pos, [Pos|R]) :- H =:= E,
    NPos is Pos + 1,
    replace_pos(T, E, NPos, R).
replace_pos([H|T], E, Pos, R) :- H =\= E,
    NPos is Pos + 1,
    replace_pos(T, E, NPos, R).

% Model matematic:
% heterList(l1...ln, list) = 
% 	[], n = 0
% 	replace_pos(l1, maxim_list(l1), 1) + heterList(l2...ln), is_list(l1) = True
% 	l1 + heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([H|T], [HR|R]) :- is_list(H), !,
    maxim_list(H, RM),
    replace_pos(H, RM, 1, HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).


% 7.
% a. Determine the position of the maximal element of a linear list.
% Eg.: maxpos([10,14,12,13,14], L) produces L = [2,5].
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% replace every sublist with the position of the maximum element from that sublist.
% [1, [2, 3], [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
% [1, [2], [1, 3], 3, 6, [2], 5, [1, 2, 3], 7]

% a

% Model matematic:
% maxim_number(a, b) = 
% 	a, a >= b
% 	b a < b

% maxim_number(A:number, B:number, R:number)
% maxim_number(i, i, o)

maxim_number(A, B, A) :- A >= B.
maxim_number(A, B, B) :- A < B.

% Model matematic:
% maxim_list(l1...ln) =
% 	l1, n = 1
% 	maxim_number(l1, maxim_list(l2...ln))
	
% maxim_list(L:list, R:number)
% maxim_list(i, o)

maxim_list([H], H).
maxim_list([H|T], R) :- 
    maxim_list(T, RM),
    maxim_number(H, RM, R).

% Model matematic:
% replace_pos(l1...ln, e, pos) =
% 	[], n = 0
% 	pos + replace_pos(l2...ln, e, pos + 1), l1 = e
%   replace_pos(l2...ln, e, pos + 1), l1 != e	

% replace_pos(L:list, E:number, Pos:number, R:list)
% flow model: replace_pos(i, i, i, o)

replace_pos([], _, _, []).
replace_pos([H|T], E, Pos, [Pos|R]) :- H =:= E,
    NPos is Pos + 1,
    replace_pos(T, E, NPos, R).
replace_pos([H|T], E, Pos, R) :- H =\= E,
    NPos is Pos + 1,
    replace_pos(T, E, NPos, R).

% maxpos(L:list, R:list)
% flow model: maxpos(i, o)
maxpos(H, R) :-
	maxim_list(H, RM),
    replace_pos(H, RM, 1, R).
% b

% Model matematic:
% heterList(l1...ln, list) = 
% 	[], n = 0
% 	replace_pos(l1, maxim_list(l1), 1) + heterList(l2...ln), is_list(l1) = True
% 	l1 + heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([H|T], [HR|R]) :- is_list(H), !,
    maxpos(H, HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).


% 8.
% a. Determine the successor of a number represented as digits in a list.
% Eg.: [1 9 3 5 9 9] --> [1 9 3 6 0 0]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% determine the successor of a sublist considered as a number.
% [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] =>
% [1, [2, 4], 4, 5, [6, 8, 0], 10, 11, [1, 2, 1], 6]

% a
% 
% Model matematic:
% my_append(l1...ln, e) =
% 	[e], n = 0
% 	l1 + my_append(l2...ln), otherwise

% my_append(L:list, E:number, R:list)
% flow model: my_append(i, i, o)

my_append([], E, [E]).
my_append([H|T], E, [H|R]) :-
    my_append(T, E, R).

% Model matematic:
% my_length(l1...ln) =
% 	0, n = 0
% 	1 + my_length(l2...ln), otherwise

% my_length(L:list, R:number)
% flow model: my_length(i, o)

my_length([], 0).
my_length([_|T], R) :-
    my_length(T, RC),
    R is RC + 1.

% Model matematic:
% inv_list(l1...ln) =
% 	[], n = 0
% 	my_append(inv_list(l2...ln), l1), otherwise

% inv_list(L:list, R:list)
% flow model: inv_list(i, o)

inv_list([], []).
inv_list([H|T], R) :-
    inv_list(T, RI),
    my_append(RI, H, R).

% Model matematic:
% sum_lists(a1...an, b1...bm) =
% 	a1...an, m = 0
% 	b1...bm, n = 0
% 	inv_list(suma(inv_list(a1...an), inv_list(b1...bm), 0)), n <= m
% 	inv_list(suma(inv_list(b1...bm), inv_list(a1...an), 0)), otherwise

% sum_lists(A:list, B:list, R:list)
% flow model: sum_lists(i, i, o)
sum_lists(A, [], A).
sum_lists([], B, B).
sum_lists(A, B, R) :-
    my_length(A, LA),
    my_length(B, LB),
    LA =< LB, !,
    inv_list(A, RA),
    inv_list(B, RB),
    suma(RA, RB, 0, RS),
    inv_list(RS, R).
sum_lists(A, B, R) :-
    inv_list(A, RA),
    inv_list(B, RB),
    suma(RB, RA, 0, RS),
    inv_list(RS, R).

% Model matematic:
% suma(a1...an, b1...bm, c) =
% 	[], n = 0 and m = 0 and c = 0
% 	[1], n = 0 and m = 0 and c = 1
% 	(b1 + c) + suma([], b2...bm, 0), n = 0 and b1 + c < 10
% 	((b1 + c) % 10) + suma([], b2...bm, 1), n = 0 and b1 + c > 10
% 	(a1 + b1 + c) + suma(a2...an, b2...bm, 0), a1 + b1 + c < 10
% 	((a1 + b1 + c) % 10) + suma(a2...an, b2...bm, 1), a1 + b1 + c > 10

suma([], [], 0, []).
suma([], [], 1, [1]).
suma([], [HB|TB], C, [HBC|R]) :-
    HBC is (HB + C) mod 10, 
    HBC - HB - C =:= 0,
    suma([], TB, 0, R).
suma([], [HB|TB], C, [HBC|R]) :-
    HBC is (HB + C) mod 10, 
    HBC - HB - C =\= 0,
    suma([], TB, 1, R).
suma([HA|TA], [HB|TB], C, [HR|R]) :-
    HR is (HA + HB + C) mod 10,
    HR - HA - HB - C =:= 0,
    suma(TA, TB, 0, R).
suma([HA|TA], [HB|TB], C, [HR|R]) :-
    HR is (HA + HB + C) mod 10,
    HR - HA - HB - C =\= 0,
    suma(TA, TB, 1, R).

% succesor(L:list, R:list)
% succesor(i, o)

succesor(L, R) :- sum_lists([1], L, R).

% b

% Model matematic:
% heterList(l1...ln, list) = 
% 	[], n = 0
% 	replace_pos(l1, maxim_list(l1), 1) + heterList(l2...ln), is_list(l1) = True
% 	l1 + heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([H|T], [HR|R]) :- is_list(H), !,
    succesor(H, HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).


% 9.
% a. For a list of integer number, write a predicate to add in list after 
% 1-st, 3-rd, 7-th, 15-th element a given value e.
% b. For a heterogeneous list, formed from integer numbers and list of numbers; 
% add in every sublist after 1-st, 3-rd, 7-th, 15-th 
% element the value found before the sublist in the heterogenous list. 
% The list has the particularity that starts with a number and there aren’t two consecutive elements lists.
% Eg.: [1, [2, 3], 7, [4, 1, 4], 3, 6, [7, 5, 1, 3, 9, 8, 2, 7], 5] =>
% [1, [2, 1, 3], 7, [4, 7, 1, 4, 7], 3, 6, [7, 6, 5, 1, 6, 3, 9, 8, 2, 6, 7], 5]

% a

% Model matematic:
% insert_list(l1...ln, e, pos) =
% 	[], n = 0
% 	l1 + e + insert_pos(l2...ln, e, pos + 1), pos % 2 = 1,
% 	l1 + insert_pos(l2...ln, e, pos + 1), otherwise

% insert_list(L:list, E:number, Pos:number, R:list)
% flow model: insert_list(i, i, i, o)

insert_list([], _, _, []).
insert_list([H|T], E, Pos, [H,E|R]) :- Pos mod 2 =:= 1, !,
    NPos is Pos + 1,
    insert_list(T, E, NPos, R).
insert_list([H|T], E, Pos, [H|R]) :-
    NPos is Pos + 1,
    insert_list(T, E, NPos, R).

% insertNb(L:list, E:number, R:list)
% flow model: insertNb(i, i, o)

insertNb(L, E, R) :- insert_list(L, E, 1, R).

% b

% Model matematic:
% heterList(l1...ln, list) = 
% 	[], n = 0
% 	l1 + insertNb(l2, l1) + heterList(l2...ln), is_list(l2) = True and number(l1)
% 	l1 + heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([E], [E]).
heterList([H1, H2|T], [H1,HR|R]) :- is_list(H2), number(H1), !,
    insertNb(H2, H1, HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).


% 10.
% a. For a list of integer numbers, define a predicate to write twice in list every prime number.
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% define a predicate to write in every sublist twice every prime number.
% Eg.: [1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5] =>
% [1, [2, 2, 3, 3], 4, 5, [1, 4, 6], 3, [1, 3, 3, 7, 7, 9, 10], 5]

% a

% Model matematic:
% nrPrim(n, div) =
% 	ture, n <= 3
% 	true, n % div != 0 and div >= n / 2
% 	nrPrim(n, div + 2), n % div != 0 and div < n / 2
% 	false, otherwise

% nrPrim(N:number, Div:number)
% flow model: nrPrim(i, i)

nrPrim(N, _) :- N > 0, N =< 3.
nrPrim(N, Div) :- N mod Div =\= 0,
    Div >= N / 2, !.
nrPrim(N, Div) :- N mod Div =\= 0,
    NDiv is Div + 2,
    nrPrim(N, NDiv).

% Model matematic:
% primeTwice(l1...ln) =
% 	[], n = 0
% 	l1 + l1 + primeTwice(l2...ln), nrPrim(l1, 3) = True,
% 	l1 + primeTwice(l2...ln), otherwise

% primeTwice(L:list, R:list)
% flow model: primeTwice(i, o)

primeTwice([], []).
primeTwice([H|T], [H,H|R]) :- nrPrim(H, 3), !,
    primeTwice(T, R).
primeTwice([H|T], [H|R]) :-
    primeTwice(T, R).

% b

% Model matematic:
% heterList(l1...ln, list) = 
% 	[], n = 0
% 	primeTwice(l1) + heterList(l2...ln), is_list(l1) = True
% 	l1 + heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([E], [E]).
heterList([H|T], [HR|R]) :- is_list(H), !,
    primeTwice(H, HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).


% 11.
% a. Replace all occurrences of an element from a list with another element e.
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% define a predicate to determine the maximum number of the list, 
% and then to replace this value in sublists with the maximum value of sublist.
% Eg.: [1, [2, 5, 7], 4, 5, [1, 4], 3, [1, 3, 5, 8, 5, 4], 5, [5, 9, 1], 2] =>
% [1, [2, 7, 7], 4, 5, [1, 4], 3, [1, 3, 8, 8, 8, 4], 5, [9, 9, 1], 2]


% a

% Model matematic:
% replaceEl(l1...ln, e1, e2) =
% 	[], n = 0
% 	e2 + replaceEl(l2...ln, e1, e2), l1 = e1
% 	l1 + replaceEl(l2...ln, e1, e2), otherwise

% replaceEl(L:list, E1:number, E2:number, R:list)
% flow model: replaceEl(i, i, i, o)

replaceEl([], _, _, []).
replaceEl([H|T], E1, E2, [E2|R]) :- H =:= E1, !,
    replaceEl(T, E1, E2, R).
replaceEl([H|T], E1, E2, [H|R]) :-
    replaceEl(T, E1, E2, R).

% b

% Model matematic:
% maxim_number(a, b) = 
% 	a, a >= b
% 	b a < b

% maxim_number(A:number, B:number, R:number)
% maxim_number(i, i, o)

maxim_number(A, B, A) :- A >= B.
maxim_number(A, B, B) :- A < B.

% Model matematic:
% maxim_list(l1...ln) =
% 	l1, n = 1
% 	maxim_number(l1, maxim_list(l2...ln)), number(l1) = True
% 	 maxim_list(l2...ln), otherwise
	
% maxim_list(L:list, R:number)
% maxim_list(i, o)

maxim_list([H], H).
maxim_list([H|T], R) :- number(H), !,
    maxim_list(T, RM),
    maxim_number(H, RM, R).
maxim_list([_|T], R) :- 
    maxim_list(T, R).

% Model matematic:
% heterList(l1...ln, m) = 
% 	[], n = 0
% 	replaceEl(l1, m, maxim_list(l1)) + heterList(l2...ln, m), is_list(l1) = True
% 	l1 + heterList(l2...ln, m), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], _, []).
heterList([H|T], M, [HR|R]) :- is_list(H), !,
    maxim_list(H, RM),
    replaceEl(H, M, RM, HR),
    heterList(T, M, R).
heterList([H|T], M, [H|R]) :-
    heterList(T, M, R).

% mainHeter(L:list, R:list)
% flow model: heterList(i, o)

mainHeter(L, R) :- 
    maxim_list(L, RM),
    heterList(L, RM, R).


% 12.
% a. Define a predicate to add after every element from a list, the divisors of that number.
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% define a predicate to add in every sublist the divisors of every element.
% Eg.: [1, [2, 5, 7], 4, 5, [1, 4], 3, 2, [6, 2, 1], 4, [7, 2, 8, 1], 2] =>
% [1, [2, 5, 7], 4, 5, [1, 4, 2], 3, 2, [6, 2, 3, 2, 1], 4, [7, 2, 8, 2, 4, 1], 2]

% a

% Model matematic:
% insert_div(l1...ln, div, list) =
% 	list, n <= 2 or n = div
% 	div + insert_div(l2...ln, div + 1, list), n % div = 0
% 	insert_div(l2...ln, div + 1, list), otherwise

% insert_div(N:number, Div:number, L:list, R:list)
% flow model: insert_div(i, i, i, o)

insert_div(N, _, L, L) :- N =< 2.
insert_div(N, N, L, L).
insert_div(N, Div, L, [Div|R]) :- N mod Div =:= 0, !,
    NDiv is Div + 1,
    insert_div(N, NDiv, L, R).
insert_div(N, Div, L, R) :-
    NDiv is Div + 1,
    insert_div(N, NDiv, L, R).

% divizori(l1...ln) =
% 	[], n = 0
% 	insert_div(l1, 2) + divizori(l2...ln), otherwise

% divizori(L:list, R:list)
% flow model: divizori(i, o)

divizori([], []).
divizori([H|T], [H|R]) :-
    divizori(T, RD),
    insert_div(H, 2, RD, R).

% b

% Model matematic:
% heterList(l1...ln) = 
% 	[], n = 0
% 	divizori(l1) + heterList(l2...ln), is_list(l1) = True
% 	l1 + heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([H|T], [HR|R]) :- is_list(H), !,
    divizori(H, HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).
    


% 13.
% a. Given a linear numerical list write a predicate to remove all sequences of consecutive values.
% Eg.: remove([1, 2, 4, 6, 7, 8, 10], L) will produce L=[4, 10].
% b. For a heterogeneous list, formed from integer numbers and list of numbers; 
% write a predicate to delete from every sublist all sequences of consecutive values.
% Eg.: [1, [2, 3, 5], 9, [1, 2, 4, 3, 4, 5, 7, 9], 11, [5, 8, 2], 7] =>
% [1, [5], 9, [4, 7, 9], 11, [5, 8, 2], 7] 

% a

% Model matematic:
% remConsecutive(l1...ln) =
% 	l1...ln, n <= 1
% 	[], n = 2 and l2 = l1 + 1
% 	remConsecutive(l2...ln), l2 = l1 + 1 and l3 = l2 + 1
% 	remConsecutive(l3...ln), l2 = l1 + 1 and l3 != l2 + 1
% 	l1 + remConsecutive(l2...ln), l2 != l1 + 1

% remConsecutive(L:list, R:list)
% flow model: remConsecutive(i, o)

remConsecutive([], []).
remConsecutive([E], [E]).
remConsecutive([H1, H2], []) :- H2 =:= H1 + 1.
remConsecutive([H1, H2], [H1, H2]) :- H2 =\= H1 + 1.
remConsecutive([H1, H2, H3|T], R) :- 
    H2 =:= H1 + 1,
    H3 =:= H2 + 1,
    remConsecutive([H2, H3|T], R).
remConsecutive([H1, H2, H3|T], R) :- 
    H2 =:= H1 + 1,
    H3 =\= H2 + 1,
    remConsecutive([H3|T], R).
remConsecutive([H1, H2, H3|T], [H1|R]) :- 
    H2 =\= H1 + 1,
    remConsecutive([H2,H3|T], R).

% b

% Model matematic:
% heterList(l1...ln) = 
% 	[], n = 0
% 	remConsecutive(l1) + heterList(l2...ln), is_list(l1) = True
% 	l1 + heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([H|T], [HR|R]) :- is_list(H), !,
    remConsecutive(H, HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).


% 14.
% a. Define a predicate to determine the longest sequences of consecutive even numbers (if exist more maximal sequences one of them).
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% define a predicate to replace every sublist with the longest sequences of even numbers from that sublist.
% Eg.: [1, [2, 1, 4, 6, 7], 5, [1, 2, 3, 4], 2, [1, 4, 6, 8, 3], 2, [1, 5], 3] =>
% [1, [4, 6], 5, [2], 2, [4, 6, 8], 2, [], 3]

% a

% Model matematic:
% even(n) =
% 	ture, n % 2 = 0
% 	false, otherwise

% even(N:number)
% flow model: even(i)

even(N) :- N mod 2 =:= 0.

% Model matematic:
% my_append(l1...ln, e) =
% 	[e], n = 0
% 	l1 + my_append(l2...ln), otherwise

% my_append(L:list, E:number, R:list)
% flow model: my_append(i, i, o)

my_append([], E, [E]).
my_append([H|T], E, [H|R]) :-
    my_append(T, E, R).

% Model matematic:
% my_length(l1...ln) =
% 	0, n = 0
% 	1 + my_length(l2...ln), otherwise

% my_length(L:list, R:number)
% flow model: my_length(i, o)

my_length([], 0).
my_length([_|T], R) :-
    my_length(T, RC),
    R is RC + 1.

% Model matematic
% consecutive(l1...ln, c1...cm, r1...rl) =
% 	r1...rl, n = 0, l > m
% 	c1...cm, n = 0, l < m
% 	consecutive(l2...ln, c1...cm, l1 + r1...rl), even(l1) = true
% 	consecutive(l2...ln, r1...rl, []) even(l1) = false and l > m
% 	consecutive(l2...ln, c1...cm, []) even(l1) = false and l < m

% consecutive(L:list, C:list, AUX: list, R:list)
% consecutive(i, i, i, o)

consecutive([], C, AUX, C) :-
    my_length(C, RC),
    my_length(AUX, RAUX),
    RC >= RAUX.
consecutive([], C, AUX, AUX) :-
    my_length(C, RC),
    my_length(AUX, RAUX),
    RC < RAUX.
consecutive([H|T], C, AUX, R) :- even(H),
    my_append(AUX, H, RA),
    consecutive(T, C, RA, R).
consecutive([_|T], C, AUX, R) :-
    my_length(C, RC),
    my_length(AUX, RAUX),
    RAUX >= RC,
    consecutive(T, AUX, [], R).
consecutive([_|T], C, AUX, R) :-
    my_length(C, RC),
    my_length(AUX, RAUX),
    RAUX < RC,
    consecutive(T, C, [], R).

% b

% Model matematic:
% heterList(l1...ln, list) = 
% 	[], n = 0
% 	consecutive(l1, [], []) + heterList(l2...ln), is_list(l1) = True
% 	l1 + heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([H|T], [HR|R]) :- is_list(H), !,
    consecutive(H, [], [], HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).


% 15.
% a. Define a predicate to determine the predecessor of a number represented as digits in a list.
% Eg.: [1 9 3 6 0 0] => [1 9 3 5 9 9]
% b. For a heterogeneous list, formed from integer numbers and list of numbers, 
% define a predicate to determine the predecessor of the every sublist considered as numbers.
% Eg.: [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] =>
% [1, [2, 2], 4, 5, [6, 7, 8], 10, 11, [1, 1, 9] 6]

% a

% Model matematic:
% predecesor(n, c) =
% 	[], n = 0
% 	[9], n = 1 and l1 = 0
% 	[l1 - 1], n = 1 and l1 != 0
% 	9 + predecesor(l2...ln, 1), c = 1 and l1 = 0
% 	(l1 - c) + predecesor(l2...ln, c), otherwise

% predecesor(L:list, C:number, R:list)
% flow model: predecesor(i, i, o)

predecesor([], _, []) :- !.
predecesor([0], 1, [9]) :- !.
predecesor([N], 0, [NR]) :- NR is N - 1, !.
predecesor([0|T], 1, [9|R]) :-
    predecesor(T, 1, R), !.
predecesor([H|T], 0, [HR|R]) :-
    predecesor(T, C, R),
    HR is H - C.

% b

% Model matematic:
% heterList(l1...ln, list) = 
% 	[], n = 0
% 	consecutive(l1, [], []) + heterList(l2...ln), is_list(l1) = True
% 	l1 + heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% flow model: heterList(i, o)

heterList([], []).
heterList([H|T], [HR|R]) :- is_list(H), !,
    predecesor(H, _, HR),
    heterList(T, R).
heterList([H|T], [H|R]) :-
    heterList(T, R).