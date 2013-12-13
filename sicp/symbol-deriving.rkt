#lang scheme

(define (deriv exp var)
	(cond ((number? exp) 0)
		  ((variable? exp)
		  	(if (same-var? exp var) 1 0))
		  ((is-op? '+ exp)
		  	(make-sum (deriv (lhs exp) var)
		  		      (deriv (rhs exp) var)))
		  ((is-op? '* exp)
		  	(make-sum
		  		(make-prod (lhs exp)
		  					  (deriv (rhs exp) var))
		  		(make-prod (deriv (lhs exp) var)
		  					  (rhs exp))))
		  ((is-op? '^ exp)
		  	(make-prod (exponent exp)
		  		          (make-power (variable exp) 
		  		          	          (make-sum (exponent exp) -1))))
		  (else
		  	(error "unexpected expression type -- DERIV" exp))))



(define (variable? x) (symbol? x))
(define (same-var? v1 v2)
	(and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-op-list op . seq)
	(reverse (foldl append (list op) seq)))

(define (is-op? op exp)
	(and (pair? exp) (eq? (car exp) op)))

(define (lhs exp) (cadr exp))

(define (rhs exp) 
	(if (= (length exp) 3)
		(caddr exp)
		(make-op-list (car exp) (cddr exp))))



(define (make-sum . seq)
	(let ((numsum (foldl + 0 (filter number? seq)))
		  (vals (filter (lambda (x) (not (number? x))) seq)))
	(cond ((= numsum 0) (if (> (length vals) 1) (make-op-list '+ vals) (car vals)))
		  ((null? vals) numsum)
		  (else (make-op-list '+ (list numsum) vals)))))

(define (make-prod . seq)
	(let ((numprod (foldl * 1 (filter number? seq)))
		  (vals (filter (lambda (x) (not (number? x))) seq)))
	(cond ((= numprod 0) 0)
		  ((= numprod 1) (make-op-list '* vals))
		  ((null? vals) numprod)
		  (else (make-op-list '* (list numprod) vals)))))

(define (make-power a pow)
	(define (=num? x val)
		(and (number? x) (= x val)))
	(cond ((=num? pow 0) 1)
		  ((=num? pow 1) a)
		  ((and (number? a) (number? pow)) (expt a pow))
		  (else (list '^ a pow))))

(define (exponent exp) (caddr exp))
(define (variable exp) (cadr exp))

(make-prod 0 'z 5 3)
(make-prod 1 2 3 (make-sum 'y 9 'x -9))
(rhs (make-prod 1 2 3 'x))

(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)

(deriv '(* (* x y) (+ x 3)) 'x)

(deriv '(+ (* 5 (^ x 3)) (+ (* 12 (^ x 2)) (+ (* 3 x) 12))) 'x)
(deriv '(+ (* 5 (^ x 3)) (* 12 (^ x 2)) (* 3 x) 12) 'x)