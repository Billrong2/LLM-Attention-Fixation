#lang racket

(define (f num)
    (append num (list (last num))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -70 20 9 1)) (list -70 20 9 1 1) 0.001)
))

(test-humaneval)
