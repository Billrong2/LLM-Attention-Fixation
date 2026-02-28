#lang racket

(define (f nums number)
  (count (lambda (x) (= x number)) nums))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 12 0 13 4 12) 12) 2 0.001)
))

(test-humaneval)
