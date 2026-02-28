#lang racket

(define (f nums elements)
  (define result '())
  (for ([i (in-range (length elements))])
    (set! result (cons (last nums) result))
    (set! nums (take nums (- (length nums) 1))))
  nums)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 7 1 2 6 0 2) (list 9 0 3)) (list 7 1 2) 0.001)
))

(test-humaneval)
