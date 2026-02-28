#lang racket

(define (f nums)
  (define count (length nums))
  (let loop ()
    (when (> (length nums) (quotient count 2))
      (set! nums (list))
      (loop)))
  nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 2 1 2 3 1 6 3 8)) (list ) 0.001)
))

(test-humaneval)
