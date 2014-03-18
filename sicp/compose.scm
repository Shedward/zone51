#lang scheme

(define (square x)
	(* x x))

(+ 2 2)

(define (compose f g)
	(lambda (x) (f (g x))))

(define (inc x)
	(+ x 1))

((compose square inc) 5)

(define (rep n f)
	(if (<= n 1)
		(lambda (x) (f x))
		(lambda (x) ((compose f (rep (- n 1) f)) x))))

(define (rev n)
	((rep n (lambda (x) (/ 1 (+ 1 x)))) n))

(rev 1)
(rev 2)
(rev 3)
(rev 4)
(rev 5)
(rev 100)


(define (smooth f dx)
	(lambda (x) (/ (+ (f (+ x dx)) (f x) (f (- x dx))) 3)))

((smooth square 1.0) 4)
((smooth square 1.0) 5)
((smooth square 1.0) 6)