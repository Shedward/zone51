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


(display " -- 3.2 -- \n")

(define (make-monitored proc)
	(let ((count 0))
		(lambda (arg)
			(cond ((eq? arg 'how-many-calls?) count)
				  ((eq? arg 'reset) (set! count 0))
				  (else (begin (set! count (+ count 1))
				  		 (proc arg)))))))

(define s (make-monitored sqrt))
(s 100)
(s 'how-many-calls?)
(s 144)
(s 256)
(s 'how-many-calls?)
(s 'reset)
(s 'how-many-calls?)


(display " -- 3.3, 3.4 -- \n")

(define (call-cops) (display "Call police!\n"))

(define (make-protected-acc pass balance)

  (define trying 7)
  (define (check-pass p proc)
  	(if (eq? pass p)
  		(begin (set! trying 7) proc)
  		(if (= trying 0) 
  			(call-cops)
  			(begin (set! trying (- trying 1))
  				   "Wrong password"))))

  (define (withdraw p amount)
  	(check-pass p
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Not enought money")))

  (define (deposit p amount)
  	(check-pass p
  	  (begin 
        (set! balance (+ balance amount))
        balance)))

  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          (else (error "Unknown command -- MAKE-ACCOUNT"
                       m))))
  dispatch)

(define acc (make-protected-acc 'qwerty 10000))
((acc 'withdraw) 'qwerty 500)
((acc 'withdraw) '123 200)
((acc 'withdraw) 'password 200)
((acc 'withdraw) '321 200)
((acc 'withdraw) '777 200)
((acc 'withdraw) '123 200)
((acc 'withdraw) '123 200)
((acc 'withdraw) '123 200)
((acc 'withdraw) '123 200)