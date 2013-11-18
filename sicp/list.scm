
(define (list-ref items n)
	(if (= n 0)
		(car items)
		(list-ref (cdr items) (- n 1))))

(define squares (list 1 4 9 16 25))
(define odds (list 1 3 5 7))
(list-ref squares 3)

(define (length items)
	(if (null? items)
		0
		(+ 1 (length (cdr items)))))
(length squares)

(define (append l1 l2)
	(if (null? l1)
		l2
		(cons (car l1) (append (cdr l1) l2))))
(append odds squares)
(append squares odds)

(define (last-pair l)
	(if (null? (cdr l))
		l
		(last-pair (cdr l))))

(last-pair odds)
(last-pair squares)


(define (reverse l)
	(if (null? l)
		(list)
		(append (reverse (cdr l)) (list (car l)))))

(define (filter pred head . tail)
	(cond 
		((null? tail) 	tail)
		((pred head) 	(cons head (apply (filter pred) tail))
		(else 			(filter pred tail))))

(newline)
(write (filter odd? 1 1 3 4 5 6))
(newline)