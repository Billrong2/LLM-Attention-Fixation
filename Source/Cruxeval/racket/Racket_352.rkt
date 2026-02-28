#lang racket

(define (f nums)
    (list-ref nums (quotient (length nums) 2)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -1 -3 -5 -7 0)) -5 0.001)
))

(test-humaneval)
