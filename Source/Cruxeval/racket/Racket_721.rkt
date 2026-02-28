#lang racket

(define (f nums)
    (define count (length nums))
    (for ([num (in-range 2 count)])
        (set! nums (sort nums <)))
    nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -6 -5 -7 -8 2)) (list -8 -7 -6 -5 2) 0.001)
))

(test-humaneval)
