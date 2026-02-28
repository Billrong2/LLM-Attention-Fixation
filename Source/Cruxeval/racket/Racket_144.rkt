#lang racket

(define (f vectors)
  (define sorted-vecs '())
  (for-each
   (lambda (vec)
     (vector-sort! vec)
     (set! sorted-vecs (cons vec sorted-vecs)))
   vectors)
  (reverse sorted-vecs))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list )) (list ) 0.001)
))

(test-humaneval)
