#lang scheme

(define (memq item x)
	(cond ((null? x) false)
		((eq? item (car x)) x)
		(else (memq item (cdr x)))))

(memq 'a '(b c d))
(memq 'a '(a (b c d) a))