#lang racket

(define (f a)
  (cond 
    [(and (>= (length a) 2) (> (list-ref a 0) 0) (> (list-ref a 1) 0))
     (reverse a)]
    [else
     (append a (list 0))]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list )) (list 0) 0.001)
))

(test-humaneval)
