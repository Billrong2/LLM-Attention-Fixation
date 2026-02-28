#lang racket

(define (f lst i n)
  (if (> i (length lst))
      lst
      (append (take lst i) (list n) (drop lst i))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 44 34 23 82 24 11 63 99) 4 15) (list 44 34 23 82 15 24 11 63 99) 0.001)
))

(test-humaneval)
