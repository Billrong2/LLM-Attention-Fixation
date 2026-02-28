#lang racket

(require racket/list)

(define (f m)
    (reverse m))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -4 6 0 4 -7 2 -1)) (list -1 2 -7 4 0 6 -4) 0.001)
))

(test-humaneval)
