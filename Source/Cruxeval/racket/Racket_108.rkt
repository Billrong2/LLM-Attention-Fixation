#lang racket

(define (f var)
  (define amount
    (if (list? var)
        (length var)
        0))
  
  (if (dict? var)
      (set! amount (hash-ref var 'keys))
      amount)
  
  (define nonzero
    (if (> amount 0)
        amount
        0))
  
  nonzero)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 1) 0 0.001)
))

(test-humaneval)
