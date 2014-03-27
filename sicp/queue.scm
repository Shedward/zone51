#lang r5rs

(define error display)

; Basic operations
(define (front-ptr queue) (car queue))
(define (back-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-back-ptr! queue item) (set-cdr! queue item))

; Queue
(define (make-queue) (cons '() '()))
(define (empty-queue? queue) (null? (front-ptr queue)))
(define (front-quee queue)
  (if (empty-queue? queue)
      (error "FRONT called with empty queue" queue)
      (car (front-ptr queue))))
(define (push-queue! queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
            (set-front-ptr! queue new-pair)
            (set-back-ptr! queue new-pair))
          (else
            (set-cdr! (back-ptr queue) new-pair)
            (set-back-ptr! queue new-pair)))
    queue))
(define (pop-queue! queue)
  (cond ((empty-queue? queue)
         (error "DELETE! called with empty queue" queue))
        (else
         (set-front-ptr! queue (cdr (front-ptr queue)))
         queue)))

(define *q (make-queue))
(push-queue! *q 'a)
(push-queue! *q 'b)
(pop-queue! *q)
(pop-queue! *q)


