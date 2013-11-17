(define (sum term a next b)
	(if (<= a b)	
		(+ (term a) (sum term (next a) next b))
		0))

(define (val x) x)

(define (inc x) (+ x 1))

(define (cube n) (* n n n))

(define (integral f a b dx)
	(define (add-dx x) (+ x dx))
	(* (sum f (+ a (/ dx 2))  add-dx b) dx))

(integral cube 0 1 0.001)

(define (sum-iter term a next b)
	(define (iter a result)
		(if (<= a  b) 
			(iter (next a) (+ a result))
			result))
	(iter a 0))

(sum-iter val 1 inc 10)

(define (reduce pred term a next b)
	(define (iter a result)
		(if (<= a  b) 
			(iter (next a) (pred a result))
			result))
	(iter (next a) a))

(reduce + val 1 inc 10)
(reduce * val 1 inc 10)

(define (rd pred a b)
	(reduce pred val a inc b))

(rd + 1 10)
(rd * 1 10)

(define (fact a b)
	(rd * a b))
(fact 1 10)

(define (fact n) (prod)) 