#lang racket

(define (f nums)
  (define m (apply max nums))
  (for ([i (in-range m)])
    (set! nums (reverse nums)))
  nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 43 0 4 77 5 2 0 9 77)) (list 77 9 0 2 5 77 4 0 43) 0.001)
))

(test-humaneval)
