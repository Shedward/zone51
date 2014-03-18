#lang scheme

(define (memq item x)
	(cond ((null? x) false)
		((eq? item (car x)) x)
		(else (memq item (cdr x)))))

(memq 'a '(b c d))
(memq 'a '(a (b c d) a))

(define (tst one . res)
	(write one)
	(newline)
	(write res))


(define (append-anyway seq val)
        (append seq (if (list? val) val (list val))))

(define (make-op-list op . seq)
	(reverse (foldl append (list op) seq)))

(make-op-list 'x '(1 2 5) '(5 6 7) 12)