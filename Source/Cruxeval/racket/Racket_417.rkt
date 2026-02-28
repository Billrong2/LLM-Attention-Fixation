#lang racket

(define (f lst)
  (reverse (reverse (rest lst))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 7 8 2 8)) (list 8 2 8) 0.001)
))

(test-humaneval)
