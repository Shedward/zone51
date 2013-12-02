#lang scheme

(define (scale-list items factor)
	(if (null? items)
		items
		(cons (* (car items) factor)
				 (scale-list (cdr items) factor))))

(write (scale-list '(1 2 3 4) 10))

(define (map proc items)
  (if (null? items)
      items
      (cons (proc (car items))
      		(map proc (cdr items)))))

(write (map abs '(10 -5 4 -1.0 2 11)))


(define (each act items)
  (act (car items))
	(each act))