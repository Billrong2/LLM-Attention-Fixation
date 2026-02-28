#lang racket

(define (f nums)
  (set! nums '())
  (for/list ([num nums])
    (* num 2)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 4 3 2 1 2 -1 4 2)) (list ) 0.001)
))

(test-humaneval)
