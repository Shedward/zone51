#lang racket

(define balance 100)

(define (withdraw amount)
  (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Not enough money"))


(define (make-withdraw balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Not enought money")))

(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Not enought money"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown command -- MAKE-ACCOUNT"
                       m))))
  dispatch)


(display " -- 3.1 -- \n")

(define (make-accum value)
	(lambda (amount)
		(begin (set! value (+ value amount))
			   value)))

(define accum1 (make-accum 10))
(accum1 3)
(accum1 50)


