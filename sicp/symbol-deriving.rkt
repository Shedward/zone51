
(define (deriv exp var)
	(cond ((number? exp) 0)
		  ((variable? exp)
		  	(if (same-var? exp var) 1 0))
		  ((sum? exp)
		  	(make-sum (deriv (addend exp) var)
		  		      (deriv (augend exp) var)))
		  ((product? exp)
		  	(make-sum
		  		(make-product (multiplier exp)
		  					  (deriv (multiplicand exp) var))
		  		(make-product (deriv (multiplier exp) var)
		  					  (multiplicand exp))))
		  ((power? exp)
		  	(make-product (power exp)
		  		          (make-power (powered exp) 
		  		          	          (make-sum (power exp) -1))))
		  (else
		  	(error "unexpected expression type -- DERIV" exp))))



(define (variable? x) (symbol? x))
(define (same-var? v1 v2)
	(and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (=num? x val)
	(and (number? x) (= x val)))



(define (make-sum a b)
	(cond ((=num? a 0) b)
		  ((=num? b 0) a)
		  ((and (number? a) (number? b)) (+ a b))
		  (else (list '+ a b))))

(define (sum? x)
	(and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s) (caddr s))



(define (make-product a b) 
	(cond ((or (=num? a 0) (=num? b 0)) 0)
		  ((=num? a 1) b)
		  ((=num? b 1) a)
		  ((and (number? a) (number? b)) (* a b))
		  (else (list '* a b))))

(define (product? x)
	(and (pair? x) (eq? (car x) '*)))
(define (multiplier x) (cadr x))
(define (multiplicand x) (caddr x))



(define (make-power a pow)
	(cond ((=num? pow 0) 1)
		  ((=num? pow 1) a)
		  ((and (number? a) (number? pow)) (expt a pow))
		  (else (list '** a pow))))

(define (power? x)
	(and (pair? x) (eq? (car x) '**)))
(define (powered x)
	(cadr x))
(define (power x)
	(caddr x))

(deriv '(+ x 3) 'x)
(deriv '(* x y) 'x)

(deriv '(* (* x y) (+ x 3)) 'x)

(deriv '(+ (* 5 (** x 3)) (+ (* 12 (** x 2)) (+ (* 3 x) 12))) 'x)