#lang scheme

(define (attach-tag type-tag contents)
	(cons type-tag contents))

(define (type-tag datum)
	(if (pair? datum)
		(car datum)
		(error "Wrong taged data -- TYPE-TAG" datum)))

(define (contents datum)
	(if (pair? datum)
		(cdr datum)
		(error "Wrong taged data -- CONTENTS" datum)))

(define (rectangular? z)
	(eq? (type-tag z) 'rectangular))

(define (polar? z)
	(eq? (type-tag z) 'polar))

