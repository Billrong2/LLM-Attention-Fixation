#lang racket

(define (f lst mode)
  (define result (map values lst))
  (if (= mode 1)
      (reverse result)
      result))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3 4) 1) (list 4 3 2 1) 0.001)
))

(test-humaneval)
