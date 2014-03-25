#lang racket

(require scheme/mpair)

(define (append! x y)
  (set-mcdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define x (list `a `b))
(define y (list `c `d))
(define z (append x y))

x
y
z

(cdr x)
(define w (append! x y))
w