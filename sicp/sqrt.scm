#lang scheme

(define (square x)
	(* x x))

'----main-------------
(define (sqrt-iter guess x)
	(if (good-enough? guess x)
		guess
		(sqrt-iter (improve guess x) x)))

(define (improve guess x)
	(average guess (/ x guess)))

(define (average x y)
	(/ (+ x y) 2))

(define (good-enough? guess x)
	(< (abs (- (square guess) x)) 0.001))

(define (sqrt x)
	(sqrt-iter 1.0 x))

(sqrt 1024)

'----With-new-if---------

(define (new-if pred thn els)
	(cond (pred thn)
		  (else els)))

(define (sqrt2 guess x)
	(new-if (good-enough? guess x)
		guess
		(sqrt2 (improve guess x) x)))

'----sum---------------------

(define (sum x)
	(if (> x 0)
		(+ x (sum (- x 1)))
		0))

(sum 50)

'----sqr3--------------------

(define (sqrt3-iter guess x)
	(if (good-enough? guess x)
		guess
		(sqrt3-iter (improve2 guess x) x)))

(define (improve2 x y)
	(/ (+ (/ x (* y y)) (* 2 y))) 3)

(sqrt 1024)