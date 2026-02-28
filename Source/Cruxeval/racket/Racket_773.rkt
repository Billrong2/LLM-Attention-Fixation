#lang racket

(define (f nums n)
    (list-ref nums n))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -7 3 1 -1 -1 0 4) 6) 4 0.001)
))

(test-humaneval)
