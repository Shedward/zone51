
(define make-segment cons)

(define begin car)

(define end cdr)


(define make-point cons)

(define x-point car)

(define y-point cdr)

(define (midpoint seg)
	(let 	((b (begin seg)) (e (end seg)))
		(make-point 
			(/ (+ (x-point b) (x-point e)) 2)
			(/ (+ (y-point b) (y-point e)) 2)
		)
	)
)

(define (print-point p)
	(newline)
	(display "(")
	(display (x-point p))
	(display ",")
	(display (y-point p))
	(display ")")
)

(midpoint (make-segment (make-point 1 1) (make-point 3 3)))


