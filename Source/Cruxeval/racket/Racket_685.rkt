#lang racket

(define (f array elem)
    (+ (length (filter (lambda (x) (= x elem)) array)) elem))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 1 1) -2) -2 0.001)
))

(test-humaneval)
