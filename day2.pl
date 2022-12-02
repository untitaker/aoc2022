#!/usr/bin/env swipl
% vi: ft=prolog

:- initialization(main).

wins(rock, scissors).
wins(scissors, paper).
wins(paper, rock).

outcome(Me, Them, win) :- wins(Me, Them).
outcome(Me, Them, loss) :- wins(Them, Me).
outcome(Me, Them, draw) :- Me = Them.

represents('A', rock).
represents('B', paper).
represents('C', scissors).

represents1('X', rock).
represents1('Y', paper).
represents1('Z', scissors).

represents2('X', loss).
represents2('Y', draw).
represents2('Z', win).

outcomeScore(win, 6).
outcomeScore(draw, 3).
outcomeScore(loss, 0).

shapeScore(rock, 1).
shapeScore(paper, 2).
shapeScore(scissors, 3).

main :-
    readFile(Lines),
    totalScore1(Lines, Score),
    writeln('part 1:'),
    writeln(Score),
    writeln('part 2:'),
    totalScore2(Lines, Score2),
    writeln(Score2),
    halt.

readFile(Lines) :-
    open('day2.txt', read, Stream),
    readLine(Stream, Lines).

readLine(Stream, Lines) :-
    at_end_of_stream(Stream) -> Lines = [] ;
    read_line_to_codes(Stream, [U, 32, V]),
    atom_codes(U2, [U]),
    atom_codes(V2, [V]),
    NewLine = [U2, V2],
    readLine(Stream, IntermediateLines),
    Lines = [NewLine|IntermediateLines].

totalScore1(Lines, Score) :-
    maplist(lineScore1, Lines, LineScores),
    foldl(plus, LineScores, 0, Score).

totalScore2(Lines, Score) :-
    maplist(lineScore2, Lines, LineScores),
    foldl(plus, LineScores, 0, Score).

lineScore1([U, V], Score) :-
    represents(U, Them),
    represents1(V, Me),
    lineScoreCommon(Me, Them, _, Score).

lineScore2([U, V], Score) :-
    represents(U, Them),
    represents2(V, Outcome),
    lineScoreCommon(_, Them, Outcome, Score).

lineScoreCommon(Me, Them, Outcome, Score) :-
    outcome(Me, Them, Outcome),
    outcomeScore(Outcome, OutcomeScore),
    shapeScore(Me, ShapeScore),
    Score is OutcomeScore + ShapeScore.
