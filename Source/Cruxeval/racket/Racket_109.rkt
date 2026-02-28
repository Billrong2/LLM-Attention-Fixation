#lang racket

(define (f nums spot idx)
    (define-values (front back) (split-at nums spot))
    (append front (list idx) back))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 0 1 1) 0 9) (list 9 1 0 1 1) 0.001)
))

(test-humaneval)
