father(terach, abraham).
father(terach, nachor).
father(terach, haran).
father(abraham, isaac).
father(haran, lot).
father(haran, milcah).
father(haran, yiscah).
mother(sarah, isaac).

male(terach).
male(abraham).
male(nachor).
male(haran).
male(isaac).
male(lot).

female(sarah).
female(milcah).
female(yiscah).

parent(Parent, Child) :- father(Parent, Child).
parent(Parent, Child) :- mother(Parent, Child).

sibling(Child1, Child2) :-  parent(Parent, Child1), parent(Parent, Child2), Child1 \= Child2.

son(Child, Parent) :- parent(Parent, Child), male(Child).
daughter(Child, Parent) :- parent(Parent, Child), female(Child).

have_kids(Man, Woman) :- father(Man, Child), mother(Woman, Child).

