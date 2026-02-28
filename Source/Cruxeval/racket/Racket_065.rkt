#lang racket

(define (f nums index)
    (+ (modulo (list-ref nums index) 42)
       (* (list-ref nums index)
          2)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 3 2 0 3 7) 3) 9 0.001)
))

(test-humaneval)
