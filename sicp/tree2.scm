#lang scheme

(define (sum-odd-squares tree)
  (cond ((null? tree) 0)
  		((not (pair? tree))
  			(if (odd? tree) (square tree) 0))
  		(else (+ (sum-odd-squares (car tree))
  				 (sum-odd-squares (cdr tree))))))

(define (filter pred seq)
	(cond ((null? seq) seq)
		  ((pred (car seq)) 
		  	(cons (car seq) (filter pred (cdr seq))))
		  (else (filter pred (cdr seq)))))

(define (accum op init seq)
	(if (null? seq)
		init
		(op (car seq) (accum op init (cdr seq)))))

(write (filter odd? (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))) (newline)
(write (accum + 0 (list 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))) (newline)

(define (enum low high)
	(if (<= low high)
		(cons low (enum (+ low 1) high))
		'()))

(write (enum 0 10)) (newline)

(define (enum-tree tree)
  (cond ((null? tree) '())
  		((not (pair? tree)) (list tree))
  		(else (append (enum-tree (car tree)) 
  					  (enum-tree (cdr tree))))))

(define X (list 1 2 (list 2 3 4) (list 2 3 (list 4 2 5)) 5 ))

(write (enum-tree X)) (newline)

(define (square x)
	(* x x))

(define (sum-odd-squares2 tree)
	(accum + 0 (map square (filter odd? (enum-tree X)))))

(write (sum-odd-squares2 X)) (newline)

(define (horner-eval x coeffs)
	(accum (lambda (this-coeff higher-term) 
				(+ (* higher-term x) this-coeff))
		   0
		   coeffs))

(write (horner-eval 2 (list 1 3 0 5 0 1))) (newline)

(define (accum-n op init seqs)
	(if (null? (car seqs))
		'()
		(cons (accum op init (map car seqs))
			  (accum-n op init (map cdr seqs)))))

(write (accum-n + 0 '((1 2 3 4) (4 5 6 7) (8 9 10 11)))) (newline)
(newline)