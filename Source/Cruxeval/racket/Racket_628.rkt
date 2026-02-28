#lang racket

(define (f nums delete)
    (remove delete nums))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 4 5 3 6 1) 5) (list 4 3 6 1) 0.001)
))

(test-humaneval)
