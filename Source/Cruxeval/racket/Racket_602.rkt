#lang racket

(define (f nums target)
  (define cnt (count (lambda (x) (equal? x target)) nums))
  (* cnt 2))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 1) 1) 4 0.001)
))

(test-humaneval)
