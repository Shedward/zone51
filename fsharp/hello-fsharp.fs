let rec fib x =
  match x with 
  | 1 -> 1
  | 2 -> 1
  | x -> fib (x - 1) + fib (x - 2)

open System

let oneYearLater = 
  DateTime.Now + new TimeSpan(365, 0, 0, 0, 0)

let (+*) a b = (a + b) * a * b
_____________________________________________________________

Some x;

