#lang racket

(define (f k j)
  (define arr '())
  (for ([i (in-range k)])
    (set! arr (append arr (list j))))
  arr)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 7 5) (list 5 5 5 5 5 5 5) 0.001)
))

(test-humaneval)
