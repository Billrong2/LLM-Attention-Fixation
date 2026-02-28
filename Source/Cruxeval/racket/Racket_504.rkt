#lang racket

(define (f values)
  (sort values <))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 1 1 1)) (list 1 1 1 1) 0.001)
))

(test-humaneval)
