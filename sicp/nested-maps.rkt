#lang scheme

(define (accum op init seq)
	(if (null? seq)
		init
		(accum op (op init (car seq)) (cdr seq))))

(accum + 0 '(1 2 3 4 5))
(map (lambda (x) (+ x 1)) '(1 2 3 4 5))

(define (enumerate-interval x y)
	(if (> x y)
		null
		(cons x (enumerate-interval (+ x 1) y))))

(enumerate-interval 1 10)


(define (fun1 n)
	(accum append
		null
		(map (lambda (i) 
			(map (lambda (j) (list i j))
				(enumerate-interval 1 (- i 1))))
			(enumerate-interval 1 n))))

(fun1 10)

(define (flatmap proc seq)
	(accum append null (map proc seq)))

(flatmap (lambda (x) (list x 2)) '(1 2 3 4 5))

(define (make-pair-sum pair)
	(list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (odd-sum-pairs n)
	(map make-pair-sum
		(filter 
			(lambda (pair) (odd? (+ (car pair) (cadr pair))))
			(flatmap 
				(lambda (i)
					(map (lambda (j) (list i j))
						(enumerate-interval 1 (- i 1))))
				(enumerate-interval 1 n)))))

(newline)
(odd-sum-pairs 15)

(define (permutations s)
	(if (null? s)
		(list null)
		(flatmap (lambda (x)
			(map (lambda (p) (cons x p))
				 (permutations (remove x s))))
		s)))
(newline)
(permutations '(1 2 3 4))


(define (unique-pairs n)
	(flatmap (lambda (i)
		(map (lambda (j) (cons i j))
			(enumerate-interval 1 i)))
	(enumerate-interval 1 n)))

(newline)
(unique-pairs 5)

(define (equal n s)
	(filter (lambda (trio)	(= (accum + trio) s)) 
		(sorted-trios n)))

(define (sorted-trios n)
	(flatmap (lambda (i)
		(map list enumerate-interval(1 n)))))

(define (zip a b)
	(map append (map list a) b))

(define (trios n)
	(if (= n 0)
		null
		()))

; (define (sorted-trios n)
; 	(define (tuples n t)
; 		(if (= t 1)
; 			(enumerate-interval 1 n)
; 			(flatmap (lambda (i)))))
; 	(map (lambda (i)
; 		) (enumerate-interval 1 n)))

(newline)

(newline)