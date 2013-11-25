
(define (accum op init seq)
	(if (null? seq)
		init
		(op (car seq) (accum op init (cdr seq)))))

(define (accum-n op init seqs)
	(if (null? (car seqs))
		'()
		(cons (accum op init (map car seqs))
			  (accum-n op init (map cdr seqs)))))

(define V '((1 2 3) (4 5 6) (7 8 9)))
(define W '((3 2 1) (6 5 4) (9 8 7)))

(define (matrix*vec m v)
	(map (lambda (mv) (accum + 0 (map * mv v))) m))

(write (matrix*vec W '(1 2 3))) (newline)

(define (transpose mat)
	(accum-n cons '() mat))

(write (transpose V)) (newline)

; from rosetacode
(define (matrix*matrix m n)
	(map
		(lambda (row)
			(apply map (lambda column (apply + (map * row column)))
				n))
		m))

(write (matrix*matrix W V)) 

(newline)