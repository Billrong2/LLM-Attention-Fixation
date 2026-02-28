#lang racket

(define (f orig)
  (define copy (list->vector orig))
  (set! copy (vector->list (vector-append copy (vector 100))))
  (set! copy (remove 100 copy))
  copy)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3)) (list 1 2 3) 0.001)
))

(test-humaneval)
