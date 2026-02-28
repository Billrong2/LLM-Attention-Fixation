#lang racket

(define (f nums)
  (define middle (quotient (length nums) 2))
  (append (drop nums middle) (take nums middle)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 1 1)) (list 1 1 1) 0.001)
))

(test-humaneval)
