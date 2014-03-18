#lang scheme

(define (abs1 x)
	(cond ((> x 0) x)
		  ((= x 0) 0)
		  ((< x 0) (- x))))

(define (abs2 x)
	(cond ((< x 0) (- x))
		  (else x)))

(define (abs x)
	(if (< x 0)
		(- x)
		x))

(define (bigger-sq-sum x y z)
	(cond ((and (<= x y) (<= x z)) (+ (* y y) (* z z)))
		  ((and (<= y z) (<= y x)) (+ (* z z) (* x x)))
		  ((and (<= z x) (<= z y)) (+ (* y y) (* x x)))
		  ))

(define (fi pred then_ else_)
	(cond (pred then_)
		  (else else_)))

(sqrt 512)