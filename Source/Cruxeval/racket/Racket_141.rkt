#lang racket

(define (f li)
  (map (lambda (i) (count (curry equal? i) li)) li))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "k" "x" "c" "x" "x" "b" "l" "f" "r" "n" "g")) (list 1 3 1 3 3 1 1 1 1 1 1) 0.001)
))

(test-humaneval)
