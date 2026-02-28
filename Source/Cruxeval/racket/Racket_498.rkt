#lang racket

(define (f nums idx added)
  (define-values (head tail) (split-at nums idx))
  (append head (list added) tail))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 2 2 2 3 3) 2 3) (list 2 2 3 2 3 3) 0.001)
))

(test-humaneval)
