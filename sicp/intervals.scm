#lang scheme

(define make-interval cons)
(define lower car)
(define upper cdr)

(define (apply f x y)
	(make-interval 
		(f (lower x) (lower y))
		(f (upper x) (upper y))))

(define X (make-interval 7 8))
(define Y (make-interval 9 11))


(define (add-interval x y) (apply + x y))
(define (mul-interval x y) (apply * x y))
(define (sub-interval x y) (apply - x y))
(define (div-interval x y) (apply / x y))

(add-interval X Y)
(mul-interval X Y)
(sub-interval X Y)
(div-interval X Y)

(define (make-center-width c w)
	(make-interval (- c w) (+ c w)))

(define (center x)
	(/ (+ (lower x) (upper x)) 2))

(define (width x)
	(/ (- (upper x) (lower x)) 2))

(define (percent x)
	(* (/ (width x) (center x)) 100.0))

(define  Xc (make-center-width 3.5 0.15))
(define  Yc (make-center-width 8 1))

(add-interval Xc Yc)
(width (add-interval Xc Yc))
(percent Xc)

(define (par1 r1 r2)
	(div-interval (mul-interval r1 r2) (add-interval r1 r2)))

(define (par2 r1 r2)
	(let ((one (make-interval 1 1)))
		(div-interval one
			(add-interval (div-interval one r1) (div-interval one r2)))))

(par1 X Y)
(par2 X Y)

(par1 Xc Yc)
(par2 Xc Yc)

'---------------
(par1 Xc Xc)
(par2 Xc Xc)
(par1 Yc Yc)
(par2 Yc Yc)

'---------------
(div-interval X Y)