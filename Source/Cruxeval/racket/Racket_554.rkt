#lang racket

(define (f arr)
    (reverse arr))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 2 0 1 9999 3 -5)) (list -5 3 9999 1 0 2) 0.001)
))

(test-humaneval)
