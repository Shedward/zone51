course(complexity, time(monday, 9, 11), lecturer(david, harel), location(feingerg, a)).
course(math, time(monday, 11, 12), lecturer(david, harel), location(feingerg, b)).
course(history, time(monday, 9, 11), lecturer(elen, mall), location(feingerg, b)).
course(complexity, time(friday, 9, 11), lecturer(david, harel), location(feingerg, a)).

lecturer(Lecturer, Course) :-
	course(Course, _, Lecturer, _).

duration(Course, Length) :-
	course(Course, time(_, Start, Finish), _, _),
	plus(Start, Length, Finish).

teaches(Lecturer, Day) :-
	course(_, time(Day, _, _), Lecturer, _).

inside(Time, Start, Finish) :-
	Start =< Time, Time < Finish.

occupied(Location, Day, Time) :-
	course(_, time(Day, Start, Finish), _, Location),
	inside(Time, Start, Finish).

busy(Lecturer, Course, Day, Time) :-
	course(Course, time(Day, Start, Finish), Lecturer, _),
	inside(Time, Start, Finish).

intersects(time(Day1, Start1, Finish1), time(Day2, Start2, Finish2)) :-
	Day1 = Day2,
	(inside(Start1, Start2, Finish2); inside(Start2, Start1, Finish1);
	inside(Finish1, Start2, Finish2); inside(Finish2, Start1, Finish1)).

overlaping(Lecturer, Course1, Course2) :-
	course(Course1, Time1, Lecturer, _),
	course(Course2, Time2, Lecturer, _),
	Course1 \= Course2, intersects(Time1, Time2).
