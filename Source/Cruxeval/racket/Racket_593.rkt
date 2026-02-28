#lang racket

(define (f nums n)
  (define pos (- (length nums) 1))
  (for ([i (in-range (- (length nums)) 0)])
    (vector-set! nums pos (vector-ref nums i)))
  nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list ) 14) (list ) 0.001)
))

(test-humaneval)
