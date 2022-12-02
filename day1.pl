#!/usr/bin/env swipl
% vi: ft=prolog

:- initialization(main).

main :-
    open('day1.txt', read, S),
    findMax(S, A, B, C),
    writeln('part a:'),
    writeln(A),
    writeln('part b:'),
    X is A + B + C,
    writeln(X),
    halt.

findMax(S, A, B, C) :-
    readElf(S, X),
    (X == 0 -> [A1, B1, C1] = [0, 0, 0] ; findMax(S, A1, B1, C1)),
    msort([A1, B1, C1, X], [_X, C, B, A]).

readElf(S, X) :-
    at_end_of_stream(S) -> X is 0 ;
    read_line_to_codes(S, Codes),
    atom_codes(Atom, Codes),
    atom_number(Atom, Number) -> (
        readElf(S, X2),
        X is X2 + Number
    ) ; X is 0.
