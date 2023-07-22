% 1.
% a. Write a predicate to determine the lowest common multiple of a list formed from integer numbers.
% b. Write a predicate to add a value v after 1-st, 2-nd, 4-th, 8-th, … element in a list.

% a

% Model matematic:
% gcd(a, b) =
%	a, b = 0
%	b, a = 0
%	gcd(a % b, b), a >= b
%	gcd(a, b % a), a < b

% gcd(A:number, B:number, R:number)
% gcd(i, i, o)

gcd(0, B, B) :- !.
gcd(A, 0, A) :- !.
gcd(A, B, R) :- A >= B,
    A1 is A mod B,
    gcd(A1, B, R), !.
gcd(A, B, R) :- A < B,
    B1 is B mod A,
    gcd(A, B1, R), !.

% Model matematic:
% lcm(a, b) = a * b / gcd(a, b)

% lcm(A:number, B:number, R:number)
% lcm(i, i, o)

lcm(A, B, R) :-
    gcd(A, B, RGCD),
    R is A * B / RGCD.

% b

% Model matematic:
% insert_pow(l1...ln, v, pos, index) =
%	[], n = 0
%	l1 + v + insert_pow(l2...ln, v, pos * 2, index + 1), index = pos
%	l1 + insert_pow(l2...ln, v, pos, index + 1), pos != index

% insert_pow(L:list, V:number, POS:number, INDEX:number, R:list)
% insert_pow(i, i, i, i, o)

insert_pow([], _, _, _, []).
insert_pow([H|T], V, POS, INDEX, [H, V|R]) :- POS =:= INDEX,
    New_pos is POS * 2,
    New_index is INDEX + 1,
    insert_pow(T, V, New_pos, New_index, R).
insert_pow([H|T], V, POS, INDEX, [H|R]) :- POS =\= INDEX,
    New_index is INDEX + 1,
    insert_pow(T, V, POS, New_index, R).

% insert(L:list, V:number, R:list)
% insert(i, i, o)

insert(L, V, R) :- insert_pow(L, V, 1, 1, R).



% 2.
% a. Write a predicate to remove all occurrences of a certain atom from a list.
% b. Define a predicate to produce a list of pairs (atom n) from an initial list of atoms.
% In this initial list atom has n occurrences.
% Eg.: numberatom([1, 2, 1, 2, 1, 3, 1], X) => X = [[1, 4], [2, 2], [3, 1]].

% a

% Model matematic:
% remove_occurences(l1...ln, e) =
%	[], n = 0
%	remove_occurences(l2...ln, e), l1 = e
%	l1 + remove_occurences(l2...ln, e), l1 != e

% remove_occurences(L:list, E:number, R:list)
% remove_occurences(i, i, o)

remove_occurences([], _, []).
remove_occurences([H|T], E, R) :- H =:= E,
    remove_occurences(T, E, R).
remove_occurences([H|T], E, [H|R]) :- H =\= E,
    remove_occurences(T, E, R).

% b

% Model matematic:
% count_occurences(l1...ln, e) =
%	0, n = 0
%	1 + count_occurences(l2...ln, e), e = l1
%	count_occurences(l2...ln, e), e != l1

% count_occurences(L:list, E:number, R:number)
% count_occurences(i, i, o)

count_occurences([], _, 0).
count_occurences([H|T], E, R) :- H =:= E,
    count_occurences(T, E, R1),
    R is R1 + 1.
count_occurences([H|T], E, R) :- H =\= E,
    count_occurences(T, E, R).

% Model matematic:
% numberatom(l1...ln) =
%	[], n = 0
%	[l1, count_occurences(l1...ln, l1)] + numberatom(remove_occurences(l2...ln, l1))

% numberatom(L:list, R:list)
% numberatom(i, o)

numberatom([], []).
numberatom([H|T], [[H, RC]|R]) :-
    count_occurences([H|T], H, RC),
    remove_occurences(T, H, RR),
    numberatom(RR, R).




% 3.
% a. Define a predicate to remove from a list all repetitive elements.
% Eg.: l=[1,2,1,4,1,3,4] => l=[2,3])
% b. Remove all occurrence of a maximum value from a list on integer numbers.

% a

% Model matematic:
% remove_occurences(l1...ln, e) =
%    [], n = 0
%    l1 + remove_occurences(l2...ln, e), l1 != e
%    remove_occurences(l2...ln, e), l1 = e

% remove_occurences(L:list, E:number, R:list)
% remove_occurences(i, i, o)

remove_occurences([], _, []).
remove_occurences([H|T], E, R) :- H =:= E,
    remove_occurences(T, E, R).
remove_occurences([H|T], E, [H|R]) :- H =\= E,
    remove_occurences(T, E, R).

% Model matematic:
% count_occurences(l1...ln, e) =
% 	0, n = 0
% 	1 + count_occurences(l2...ln, e), e = l1
% 	count_occurences(l2...ln, e), e != l1

% count_occurences(L:list, E:number, R:number)
% count_occurences(i, i, o)

count_occurences([], _, 0).
count_occurences([H|T], E, R) :- H =:= E,
    count_occurences(T, E, R1),
    R is R1 + 1.
count_occurences([H|T], E, R) :- H =\= E,
    count_occurences(T, E, R).

% Model matematic:
% remove_repetitive(l1...ln) =
% 	[], n = 0
% 	l1 + remove_repetitive(l2...ln), count_occurences(l1...ln, l1) = 1
% 	remove_repetitive(remove_occurences(l1...ln, l1)), count_occurences(l1...ln, l1) != 1
	
% remove_repetitive(L:list, R:list)
% remove_repetitive(i, o)

remove_repetitive([], []).
remove_repetitive([H|T], [H|R]) :-
    count_occurences([H|T], H, RC),
    RC =:= 1,
    remove_repetitive(T, R).
remove_repetitive([H|T], R) :-
    count_occurences([H|T], H, RC),
    RC =\= 1,
    remove_occurences([H|T], H, RO),
    remove_repetitive(RO, R).

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

% remove_maxim(l1...ln) =
% 	remove_occurences(l1...ln, maxim_list(l1...ln))			

% remove_maxim(L:list, R:list)
% remove_maxim(i, o)

remove_maxim(L, R) :-
    maxim_list(L, RM),
    remove_occurences(L, RM, R).



% 4.
% a. Write a predicate to determine the difference of two sets.
% b. Write a predicate to add value 1 after every even element from a list.

% a

% Model matematic:
% contains(l1..ln, e) =
% 	false, n = 0
% 	true, l1 = e
% 	contains(l2...ln, e), otherwise
	
% contains(L:list, E:number)
% contains(i, i)

contains([V|_], V) :- !.
contains([_|T], V) :- contains(T, V).

% (A - B), where A and B sets
% Model matematic:
% difference(a1...an, b1...bn) =
% 	[], n = 0
% 	difference(a2...an, b1...bn), contains(b1...bn, a1) = true
% 	a1 + difference(a2...an, b1...bn), otherwise

% difference(A:list, B:list, R:list)
% difference(i, i, o)

difference([], _, []).
difference([H|T], B, R) :-
    contains(B, H),
    difference(T, B, R), !.
difference([H|T], B, [H|R]) :-
    difference(T, B, R).

% b

% Model matematic:
% insert1(l1...ln) =
% 	[], n = 0
% 	l1 + 1 + insert1(l2...ln), l1 % 2 = 0
% 	l1 + insert1(l2...ln), l1 % 2 != 0

% insert1(L:list, R:list)
% insert1(i, o)

insert1([], []).
insert1([H|T], [H, 1|R]) :- 
    H mod 2 =:= 0,
    insert1(T, R).
insert1([H|T], [H|R]) :- 
    H mod 2 =\= 0,
    insert1(T, R).


% 5.
% a. Write a predicate to compute the union of two sets.
% b. Write a predicate to determine the set of all the pairs of elements in a list.
% Eg.: L = [a b c d] => [[a b] [a c] [a d] [b c] [b d] [c d]].
 
% a

% Model matematic:
% remove_occurences(l1...ln, e) =
%    [], n = 0
%    l1 + remove_occurences(l2...ln, e), l1 != e
%    remove_occurences(l2...ln, e), l1 = e

% remove_occurences(L:list, E:number, R:list)
% remove_occurences(i, i, o)

remove_occurences([], _, []).
remove_occurences([H|T], E, R) :- H =:= E,
    remove_occurences(T, E, R).
remove_occurences([H|T], E, [H|R]) :- H =\= E,
    remove_occurences(T, E, R).

% Model matematic:
% union(a1...an, b1...bm) =
% 	[], n = 0 and m = 0
% 	a1 + union(remove_occurences(a1...an, a1), remove_occurences(b1...bm, a1)), n > 0
% 	union(b1...bm, []), n = 0

% union(A:list, B:list, R:list)
% union(i, i, o)

union([], [], []).
union([H|T], B, [H|R]) :-
    remove_occurences([H|T], H, R1),
    remove_occurences(B, H, R2),
    union(R1, R2, R).
union([], B, R) :-
      union(B, [], R).

% b

% Model matematic:
% sets(l1...ln, k) =
% 	[], k = 0
% 	l1 + sets(l2...ln, k - 1), k > 0
% 	sets(l2...ln, k), k > 0

% sets(L:list, K:number, R:list)
% sets(i, i, o)

sets(_, 0, []) :- !.
sets([H|T], K, [H|R]) :-
    K1 is K - 1,
    sets(T, K1, R).
sets([_|T], K, R) :-
    sets(T, K, R).

% Model matematic:
% gen_sets(l1..ln) =
% 	[], n = 0
% 	findall(sets(l1...ln, 2))

% gen_sets(L:list, R:list)
% gen_sets(i, o)

gen_sets([], []).
gen_sets(L, R) :- findall(RS, sets(L, 2, RS), R).



% 6.
% 6.
% a. Write a predicate to test if a list is a set.
% b. Write a predicate to remove the first three occurrences of an element in a list. 
% If the element occurs less than three times, all occurrences will be removed.

% a

% Model matematic:
% count_occurences(l1...ln, e) =
% 	0, n = 0
% 	1 + count_occurences(l2...ln, e), l1 = e
% 	count_occurences(l2...ln, e), l1 != e

% count_occurences(L:list, E:number, R:number)
% count_occurences(i, i, o)

count_occurences([], _, 0).
count_occurences([H|T], E, R1) :- H =:= E,
    count_occurences(T, E, R),
    R1 is R + 1.
count_occurences([H|T], E, R) :- H =\= E,
    count_occurences(T, E, R).

% Model matematic:
% test_set(l1...ln) =
% 	true, n = 0
% 	false, count_occurences(l1...ln, l1) != 1
% 	test_set(l2...ln), otherwise

% test_set(L:list)
% test_set(i)

test_set([]).
test_set([H|T]) :- 
    count_occurences([H|T], H, R),
    R =:= 1,
    test_set(T), !.

% b

% Model matematic:
% remove_k_occurences(l1...ln, e, k) =
% 	[], n = 0
% 	l1...ln, k = 0
% 	remove_k_occurences(l2...ln, e, k - 1), l1 = e
% 	l1 + remove_k_occurences(l2...ln, e, k), l1 != e

% remove_k_occurences(L:list, E:number, K:number, R:list)
% remove_k_occurences(i, i, i, o)

remove_k_occurences([], _, _, []) :- !.
remove_k_occurences(L, _, 0, L) :- !.
remove_k_occurences([H|T], E, K, R) :- H =:= E,
    K1 is K - 1,
    remove_k_occurences(T, E, K1, R).
remove_k_occurences([H|T], E, K, [H|R]) :- H =\= E,
     remove_k_occurences(T, E, K, R).

% remove_3_occurences(L:list, E:number, R:list)
% remove_3_occurences(i, i, o)

remove_3_occurences(L, E, R) :- remove_k_occurences(L, E, 3, R).


% 7.
% 7.
% a. Write a predicate to compute the intersection of two sets.
% b. Write a predicate to create a list (m, ..., n) of all integer numbers from the interval [m, n].

% a

% Model matematic:
% contains(l1...ln, e) =
% 	false, n = 0
% 	true, l1 = e
%	contains(l2...ln, e), otherwise

% contains(L:list, E:number)
% contains(i, i)

contains([V|_], V) :- !.
contains([_|T], E) :- contains(T, E).

% Model matematic:
% intersection(a1...an, b1...bm) =
% 	[], n = 0
% 	a1 + intersection(a2...an, b1...bm), contains(b1...bm, a1) = true
% 	intersection(a2...an, b1...bm), otherwise

% intersection(A:list, B:list, R:list)
% intersection(i, i, o)

intersection([], _, []).
intersection([H|T], B, [H|R]) :-
    contains(B, H),
    intersection(T, B, R), !.
intersection([_|T], B, R) :- intersection(T, B, R).

% b

% Model matematic:
% new_list(m, n) =
% 	[], m = n
% 	m + new_list(m + 1, n)

% new_list(M:number, N:number, R:list)
% new_list(i, i, o)
 
new_list(N, N, [N]).
new_list(M, N, [M|R]) :- 
    New_m is M + 1,
    new_list(New_m, N, R).



% 8.
% a. Write a predicate to determine if a list has even numbers of elements 
% without counting the elements from the list.
% b. Write a predicate to delete first occurrence of the minimum number from a list.

% a

% Model matematic:
% even_list(l1...ln) =
% 	true, n = 0
% 	false, n = 1
% 	even_list(l3...ln), otherwise
 
% even_list(L:list)
% even_list(i)

even_list([]).
even_list([_, _|T]) :- even_list(T).

% b

% Model matematic:
% min_numbers(a, b) =
% 	a, a <= b
% 	b, a > b

% min_numbers(A:number, B:number, R:number)
% min_numbers(i, i, o)

min_numbers(A, B, A) :- A =< B.
min_numbers(A, B, B) :- A > B.

% Model matematic:
% minim_list(l1...ln) =
% 	l1, n = 1
% 	min_numbers(l1, minim_list(l2...ln)), otherwise
	
% minim_list(L:list, R:number)
% minim_list(i, o)

minim_list([H], H).
minim_list([H|T], R) :- 
    minim_list(T, R1),
    min_numbers(H, R1, R).

% Model matematic:
% delete_first_occurence(l1...ln, m) =
% 	l2...ln, l1 = m
% 	l1 + delete_first_occurence(l2...ln, m), otherwise

% delete_first_occurence(L:list, M:number, R:list)
% delete_first_occurence(i, i, o)

delete_first_occurence([H|T], H, T) :- !.
delete_first_occurence([H|T], M, [H|R]) :- delete_first_occurence(T, M, R).

% delete_first_min(L:list, R:list)
% delete_first_min(i, o)

delete_first_min(L, R) :-
    minim_list(L, RM),
    delete_first_occurence(L, RM, R).



% 9.
% a. Insert an element on the position n in a list.
% b. Define a predicate to determine the greatest common divisor of all numbers from a list

% a

% Model matematic:
% insert_value_in_list_on_position(l1...ln, e, p) =
% 	e + l1...ln, p = 0
% 	l1 + insert_value_in_list_on_position(l2...ln, e, p - 1), otherwise

% insert_value_in_list_on_position(L:list, E:number, P:number, R:list)
% insert_value_in_list_on_position(i, i, i, o)
insert_value_in_list_on_position(L, E, 0, [E|L]):-!.
insert_value_in_list_on_position([H|T], E, P, [H|R]):-
    P1 is P - 1,
    insert_value_in_list_on_position(T, E, P1, R).

% b
 
% Model matematic:
% gcd(a, b) =
%	a, b = 0
%	b, a = 0
%	gcd(a % b, b), a >= b
%	gcd(a, b % a), a < b

% gcd(A:number, B:number, R:number)
% gcd(i, i, o)

gcd(0, B, B) :- !.
gcd(A, 0, A) :- !.
gcd(A, B, R) :- A >= B,
    A1 is A mod B,
    gcd(A1, B, R), !.
gcd(A, B, R) :- A < B,
    B1 is B mod A,
    gcd(A, B1, R), !.

% Model matematic:
% gcd_list(l1...ln) =
% 	l1, n = 1
% 	gcd(l1, gcd_list(l2...ln)), otherwise
	
% gcd_list(L:list, R:number)
% gcd_list(i, o)

gcd_list([H], H).
gcd_list([H|T], R) :- 
    gcd_list(T, R1),
    gcd(R1, H, R).



% 10.
% a. Define a predicate to test if a list of an integer elements has a "valley" aspect (a set has a "valley" aspect if
% elements decreases up to a certain point, and then increases.
% eg: 10 8 6 9 11 13 – has a “valley” aspect
% b. Calculate the alternate sum of list’s elements (l1 - l2 + l3 ...).

% a

% Model matematic:
% valley(l1...ln, f) =
% 	true, n = 1 and f = 0
% 	valley(l2...ln, 0), l1 < l2
% 	valley(l2...ln, 1), l1 > l2
% 	false, otherwise

% valley(L:list, F:number)
% valley(i, i)

valley([_], 0).
valley([H1, H2|T], _) :- H1 < H2, 
    valley([H2|T], 0), !.
valley([H1, H2|T], 1) :- H1 > H2,
    valley([H2|T], 1), !.

% b

% Model matematic:
% alternative_sum(l1...ln) =
% 	0, n = 0
% 	l1, n = 1
% 	l1 - l2 + alternative_sum(l3...ln), otherwise

% alternative_sum(L:list, R:number)
% alternative_sum(i, o)

alternative_sum([], 0).
alternative_sum([H], H).
alternative_sum([H1, H2|T], R) :-
    alternative_sum(T, R1),
    R is H1 - H2 + R1.



% 11.
% a. Write a predicate to substitute an element from a list with another element in the list.
% b. Write a predicate to create the sublist (lm, …, ln) from the list (l1,…, lk).

% a

% Model matematic:
% substitute_elem(l1...ln, e1, e2) =
% 	[], n = 0
% 	e2 + substitute_elem(l2...ln, e1, e2), l1 = e1
% 	l1 + substitute_elem(l2...ln, e1, e2), l1 != e1
	
% substitute_elem(L:list, E1:number, E2:number, R:list)
% substitute_elem(i, i, i, o)

substitute_elem([], _, _, []) :- !.
substitute_elem([H|T], E1, E2, [E2|R]) :- H =:= E1,
    substitute_elem(T, E1, E2, R).
substitute_elem([H|T], E1, E2, [H|R]) :- H =\= E1,
    substitute_elem(T, E1, E2, R).

% b
 
% Model matematic:
% sublist(l1...lk, m, n, pos) =
% 	[], pos > n
% 	l1 + sublist(l2...lk, m, n, pos + 1), m < pos and pos < n
% 	sublist(l2...lk, m, n, pos + 1), otherwise

% sublist(L:list, M:number, N:number, POS:number, R:list)
% sublist(i, i, i, o)

sub_list(_, _, N, POS, []) :- POS > N, !.
sub_list([H|T], M, N, POS, [H|R]) :- M =< POS, POS =< N,
    New_pos is POS + 1,
    sub_list(T, M, N, New_pos, R), !.
sub_list([_|T], M, N, POS, R) :-
    New_pos is POS + 1,
    sub_list(T, M, N, New_pos, R).



% 12.
% a. Write a predicate to substitute in a list a value with all the elements of another list.
% b. Remove the n-th element of a list

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
% remove_n(l1...ln, k) =
% 	[], n = 0
% 	l2...ln, k = 1
% 	l1 + remove_n(l2...ln, k -1), otherwise

% remove_n(L:list, K:number, R:list)
% remove_n(i, i, o)

remove_n([], _, []).
remove_n([_|T], 1, T).
remove_n([H|T], K, [H|R]) :-
    K1 is K - 1,
    remove_n(T, K1, R).



% 13.
% a. Transform a list in a set, in the order of the last occurrences of elements. 
% Eg.: [1,2,3,1,2] is transformed in [3,1,2].
% b. Define a predicate to determine the greatest common divisor of all numbers in a list

% a

% Model matematic:
% count_occurences(l1...ln, e) =
% 	0, n = 0
% 	1 + count_occurences(l2...ln, e), l1 = e
% 	count_occurences(l2...ln, e), otherwise
 	
% count_occurences(L:list, E:number, R:number)
% count_occurences(i, i, o)

count_occurences([], _, 0).
count_occurences([H|T], E, R) :- H =:= E,
    count_occurences(T, E, R1),
    R is R1 + 1.
count_occurences([H|T], E, R) :- H =\= E,
    count_occurences(T, E, R).


% Model matematic:
% list_to_set(l1...ln) =
% 	[], n = 0
% 	l1 + list_to_set(l2...ln), count_occurences(l2...ln, l1) = 0
% 	list_to_set(l2...ln), otherwise
 	
% list_to_set(L:list, R:list)
% list_to_set(i, o)

list_to_set([], []) :- !.
list_to_set([H|T], [H|R]) :- 
    count_occurences(T, H, RC),
    RC =:= 0,
    list_to_set(T, R), !.
list_to_set([_|T], R) :-
    list_to_set(T, R).

% b
 
% Model matematic:
% gcd(a, b) =
%	a, b = 0
%	b, a = 0
%	gcd(a % b, b), a >= b
%	gcd(a, b % a), a < b

% gcd(A:number, B:number, R:number)
% gcd(i, i, o)

gcd(0, B, B) :- !.
gcd(A, 0, A) :- !.
gcd(A, B, R) :- A >= B,
    A1 is A mod B,
    gcd(A1, B, R), !.
gcd(A, B, R) :- A < B,
    B1 is B mod A,
    gcd(A, B1, R), !.

% Model matematic:
% gcd_list(l1...ln) =
% 	l1, n = 1
% 	gcd(l1, gcd_list(l2...ln)), otherwise
	
% gcd_list(L:list, R:number)
% gcd_list(i, o)

gcd_list([H], H).
gcd_list([H|T], R) :- 
    gcd_list(T, R1),
    gcd(R1, H, R).



% 15.
% a. Write a predicate to transform a list in a set, considering the first occurrence.
% Eg: [1,2,3,1,2] is transform in [1,2,3].
% b. Write a predicate to decompose a list in a list respecting the following: 
% [list of even numbers list of odd numbers] and also return the number of even numbers and the numbers of odd numbers.

% a

% Model matematic:
% remove_occurences(l1...ln, e) =
%    [], n = 0
%    l1 + remove_occurences(l2...ln, e), l1 != e
%    remove_occurences(l2...ln, e), l1 = e

% remove_occurences(L:list, E:number, R:list)
% remove_occurences(i, i, o)

remove_occurences([], _, []).
remove_occurences([H|T], E, R) :- H =:= E,
    remove_occurences(T, E, R).
remove_occurences([H|T], E, [H|R]) :- H =\= E,
    remove_occurences(T, E, R).

% Model matematic:
% list_to_set(l1...ln) =
% 	[], n = 0
% 	l1 + list_to_set(remove_occurences(l2...ln, l1)), otherwise
 	
% list_to_set(L:list, R:list)
% list_to_set(i, o)

list_to_set([], []).
list_to_set([H|T], [H|R]) :- 
    remove_occurences(T, H, R1),
    list_to_set(R1, R).

% b
% 
% Model matematic:
% decompose(l1...ln)
% 	[0, 0, [], []], n = 0
% 	{decompose(l2...ln), 1 + nr_even, l1 + even_list}, l1 % 2 = 0
% 	{decompose(l2...ln), 1 + nr_odd, l1 + odd_list}, l1 % 2 = 1

% decompose(L:list, R:list)
% decompose(i, o)

decompose([], [0, 0, [], []]).
decompose([H|T], [H1f, H2, [H|H3], H4]) :- H mod 2 =:= 0,
    decompose(T, [H1, H2, H3, H4]),
	H1f is H1 + 1.
decompose([H|T], [H1, H2f, H3, [H|H4]]) :- H mod 2 =:= 1,
    decompose(T, [H1, H2, H3, H4]),
	H2f is H2 + 1.