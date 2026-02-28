#lang racket

(define (f nums)
    (for ([_ (in-range (- (length nums) 1))])
        (set! nums (reverse nums)))
    nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 -9 7 2 6 -3 3)) (list 1 -9 7 2 6 -3 3) 0.001)
))

(test-humaneval)
