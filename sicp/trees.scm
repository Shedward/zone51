
(define x (cons (list 1 2) (list 3 4)))

(write x)
(newline)

(define (count-leave x)
  (cond ((null? x) 0)
  		((not (pair? x)) 1)
  		(else (+ (count-leave (car x))
  				 (count-leave (cdr x))))))

(write (count-leave x))
(newline)

(write (list 1 (list 2 (list 3 4))))
(newline)

(write (cdr (car (cdr (cdr (list 1 3 (cons 5 7) 9))))))
(write (car (car (list (list 7)))))
(write (cdr (cdr (cdr (cdr (cdr (cdr (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 (cons 6 7)))))))))))))
(newline)

(define x (list 1 2 3))
(define y (list 4 5 6))

(write (append x y)) ; (1 2 3 4 5 6)
(write (cons x y)) ; ((1 2 3) 4 5 6)
(write (list x y)) ; ((1 2 3) (4 5 6))
(newline)

(define (reverse items)
  (if (null? items) items
  	  (append (reverse (cdr items)) (list (car items)))))

(write (reverse (list 1 2 3 3 5)))
(newline)

(define X (list (list 2 3 4 (list 5 1) (list 1 2 3)) 11 12 (list 13)))
(write X) (newline)
(write (reverse X)) (newline)

;(define (deep-rev tree)
;	(let ((rtree (reverse tree))
;		(define (iter list)
;			(append (list (if (list? (car list)) (deep-rev (car list)) (car list)))
;					(iter rest))))))

(define (deep-rev tree)
	(define (rev-subtrees subtrees)
		(cond ((pair? subtrees)
			  (append (rev-subtrees (cdr subtrees))
			  		  (list (rev-subtrees (car subtrees)))))
			  (else subtrees)))
	(rev-subtrees (list tree)))

(write (reverse (deep-rev X)))
(newline)

(define (fringe tree)
	(define (to-list l)
		(if (list? l) l (list l)))
	(cond ((pair? tree) 
			(append (to-list (fringe (car tree)))
					(to-list (fringe (cdr tree)))))
		  (else tree)))
(write (fringe X))
(newline)

(define (make-mobile left right)
	(list left right))

(define (make-branch length struct)
	(list length struct))

(define left car)
(define right cadr)

(define length car)
(define struct cadr)

(define (total-weight tree)
	(if (pair? tree)
		(+ (total-weight (struct (left tree)))
		   (total-weight (struct (right tree))))
		 tree))

(define (try act pair)
	(if (pair? pair)
		(act pair)
		pair))

(define (moment tree)
	(define (length branch)
		(if (pair? (struct branch))
			(cons (+ (length branch) (car (length (left (struct branch)))))
				  (+ (length branch) (cdr (length (right (struct branch)))))))
		(length branch))
	(* (car (length (left tree))) (total-weight (struct (left tree)))
	   (car (length (right tree))) (total-weight (struct (right tree))))
)

;((1 ((2 3) (4 5))) 

;	((2 3) 6
;	(4 5)) 20

;(6 7)) ; 42

(define (weighted? tree)
	(let ((m (moment tree)))
		(= (car m) (cdr m))))

(define X (make-mobile 
			(make-branch 1 
				(make-mobile (make-branch 2 3)
				      		 (make-branch 4 5)))
			(make-branch 6 7)))

(write X) (newline)
(write (total-weight X)) (newline)
(write (moment X))

(newline)