#lang racket

(define (f s)
  (when (> (length s) 1)
    (set! s '())
    (set! s (list (length s))))
  (car s))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 6 1 2 3)) 0 0.001)
))

(test-humaneval)
