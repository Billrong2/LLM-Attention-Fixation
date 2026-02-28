#lang racket

(define (f a b)
  (define sorted-a (sort a <))
  (define sorted-b (sort b >))
  (append sorted-a sorted-b))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 666) (list )) (list 666) 0.001)
))

(test-humaneval)
