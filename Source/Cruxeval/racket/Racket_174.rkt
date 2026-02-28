#lang racket

(define (f lst)
  (define lst-start (take lst 1))
  (define lst-middle (reverse (take (drop lst 1) 2)))
  (define lst-end (drop lst 3))
  (append lst-start lst-middle lst-end))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3)) (list 1 3 2) 0.001)
))

(test-humaneval)
