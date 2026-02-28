#lang racket

(define (f lst)
  (define sorted-list (sort lst <))
  (take sorted-list 3))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 5 8 1 3 0)) (list 0 1 3) 0.001)
))

(test-humaneval)
