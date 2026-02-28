#lang racket

(define (f nums)
  (set! nums (reverse nums))
  nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -6 -2 1 -3 0 1)) (list 1 0 -3 1 -2 -6) 0.001)
))

(test-humaneval)
