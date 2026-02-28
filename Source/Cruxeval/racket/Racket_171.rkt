#lang racket

(define (f nums)
  (define count (quotient (length nums) 2))
  (for ([_ (in-range count)])
    (set! nums (cdr nums)))
  nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 3 4 1 2 3)) (list 1 2 3) 0.001)
))

(test-humaneval)
