#lang scheme 

(define (square x)
	(* x x))

(define (f x y)
	(define (f-helper a b)
		(+ (* x (square a))
			(* y b)
			(* a b)))
	(f-helper (+ 1 (* x y))
			  (- 1 y)))

(define (f1 x y)
	((lambda (a b)
		(+ (* x (square a))
			(* y b)
			(* a b)))
		(+ 1 (* x y))
		(- 1 y)))

(define (f2 x y)
	(let ((a (+ 1 (- x y)))
		  (b (- 1 y)))
	(+ (* x (square a))
		(* y b)
		(* a b))))

(define (average x y)
	(/ (+ x y) 2))

(define (close-enough? x y)
	(< (abs (- x y)) 0.000001))

(define (search f neg-point pos-point)
	(let ((mid-point (average neg-point pos-point)))
		(if (close-enough? neg-point pos-point)
			mid-point
			(let ((test-value (f mid-point)))
				(cond ((positive? test-value) 
					(search f neg-point mid-point))
				((negative? test-value)
					(search f mid-point pos-point))
				(else mid-point))))))

(define (half-interval-method f a b)
	(let ((a-val (f a))	(b-val (f b)))
		(cond 
			((and (negative? a-val) (positive? b-val)) 
				(search f a b))
			((and (positive? a-val) (negative? b-val))
				(search f b a))
			(else (error "Same sighn")))))

(half-interval-method sin 2.0 4.0)
(half-interval-method (lambda (x) (- (* x x x) (* 2 x) 3)) 1.0 2.0)
(half-interval-method (lambda (x) x) -10.0 9.0)

(define (fixed-point f first-guess)
	(define (try-guess guess)
		(let ((next (f guess)))
			(if (close-enough? guess next)
				next
				(try-guess next))))
	(try-guess first-guess))

(fixed-point cos 1.0)
(fixed-point (lambda (x) (+ 1 (/ 1 x))) 1.0)

(define (dd f)
	(lambda (x)
		(/ (- (f (+ x 0.00001)) (f x)) 0.00001)))

(define (cube x) (* x x x))

((dd cube) 5)

(define (newton-transform g)
	(lambda (x)
		(- x (/ (g x) ((dd g) x)))))

(define (newtons-method g guess)
	(fixed-point (newton-transform g) guess))

(define (sqrt x)
	(newtons-method (lambda (y) (- (square y) x)) 1.0))