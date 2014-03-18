#lang scheme

(define (f n)
	(if (< n 3)
		n
		(+ (f (- n 1)) 
		   (f (- n 2)) 
		   (f (- n 3))
		)
	)
)

(f 10)

(define (f2 n)
	(define (f-iter it a b c)
		(if (< it n)
			(f-iter (+ it 1) 
					b 
					(+ a b)
					(+ a b c))
			c))
	(if (< n 3)
		n
		(f-iter 3 1 2 3)))

(f2 10)