#!/usr/bin/env swipl
% vi: ft=prolog

:- use_module(library(ordsets)).
:- initialization(main).

main :-
    open('day3.txt', read, Stream),
    readFile(Stream, Lines),
    writeln('part 1'),
    part1(Lines, Score),
    writeln(Score),
    writeln('part 2'),
    part2(Lines, Score2),
    writeln(Score2),
    halt.

% split a list in the middle.
halve(A, B, AB) :-
    length(AB, N),
    N2 is N // 2,
    length(A, N2),
    length(B, N2),
    append(A, B, AB).

codeScore(Code, Score) :- Score is (Code - 65 + 27) mod 58.

readFile(Stream, Lines) :-
    at_end_of_stream(Stream) -> Lines = [] ;
    read_line_to_codes(Stream, Codes),
    readFile(Stream, IntermediateLines),
    Lines = [Codes|IntermediateLines].

part1([], 0).
part1([Line|Lines], Score) :-
    halve(HalfA, HalfB, Line),
    intersection(HalfA, HalfB, [Intersection|_]),
    codeScore(Intersection, Score1),
    part1(Lines, Score2),
    Score is Score1 + Score2.

part2([], 0).
part2(Lines, Score) :-
    append([Line1, Line2, Line3], LinesRest, Lines),
    intersection(Line1, Line2, Line12),
    intersection(Line12, Line3, [Intersection|_]),
    codeScore(Intersection, Score1),
    part2(LinesRest, Score2),
    Score is Score1 + Score2.
