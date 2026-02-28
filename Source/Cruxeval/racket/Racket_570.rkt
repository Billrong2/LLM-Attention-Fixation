#lang racket

(define (f array index value)
    (define new-array (cons (+ index 1) array))
    (if (>= value 1)
        (cons value new-array)
        new-array))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 2) 0 2) (list 2 1 2) 0.001)
))

(test-humaneval)
