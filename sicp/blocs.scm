#lang scheme

'---Block--------

(define (square x)
	(* x x))

(define (sqrt x)
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

	(sqrt-iter 1.0 x))

(sqrt 1024)

'---Easy---------

(define (sqrt2 x)
	(define (sqrt-iter guess)
		(if (good-enough? guess)
			guess
			(sqrt-iter (improve guess))))

	(define (improve guess)
		(average guess (/ x guess)))

	(define (average x y)
		(/ (+ x y) 2))

	(define (good-enough? guess)
		(< (abs (- (square guess) x)) 0.001))

	(sqrt-iter 1.0))

(sqrt2 1024)