#lang scheme

(define (reminder a b)
	(floor (/ a b)))

(define (square x)
	(* x x))

(define (expmod base exp m)
	(cond ((= exp 0) 1)
		((even? exp) (reminder (square (expmod base (/ exp 2) m)) m))
		(else (reminder (* base (expmod base (- exp 1) m)) m))))

(expmod 10 2 50)

(define (fermat-test n)
	(define (try-it a)	(= (expmod a n n) a))
		(try-it (+ 1 (random (- n 1)))))

(fermat-test 50)


(define (fast-prime? n times)
	(cond 
		((= times 0) true)
		((fermat-test n) (fast-prime? n (- times 1)))
		(else false)))

(fast-prime? 2558 10)

(define (timed-prime-test n)
	(newline)
	(display n)
	(start-prime-test n (current-milliseconds)))

(define prime? fast-prime?)

(define (start-prime-test n start-time)
	(if (prime? n)
		(report-prime (- (current-milliseconds) start-time))
		null))

(define (report-prime elapsed-time)
	(display " *** ")
	(display elapsed-time))

