#lang racket

(define (f nums pop1 pop2)
  (set! nums (remove (list-ref nums (- pop1 1)) nums))
  (set! nums (remove (list-ref nums (- pop2 1)) nums))
  nums)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 5 2 3 6) 2 4) (list 1 2 3) 0.001)
))

(test-humaneval)
