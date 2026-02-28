#lang racket

(define (f array)
  (define return_arr '())
  (for-each (lambda (a) (set! return_arr (append return_arr (list a)))) array)
  return_arr)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list (list 1 2 3) (list ) (list 1 2 3))) (list (list 1 2 3) (list ) (list 1 2 3)) 0.001)
))

(test-humaneval)
