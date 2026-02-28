#lang racket

(define (f array n)
    (drop array n))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 0 1 2 2 2 2) 4) (list 2 2 2) 0.001)
))

(test-humaneval)
