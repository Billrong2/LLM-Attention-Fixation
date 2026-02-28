#lang racket

(define (f nums)
  (set! nums '())
  "quack")
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 2 5 1 7 9 3)) "quack" 0.001)
))

(test-humaneval)
