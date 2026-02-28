#lang racket

(define (f nums target)
  (cond 
    [(member 0 nums) 0]
    [(< (count (λ (n) (equal? n target)) nums) 3) 1]
    [else (index-of nums target)]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 1 1 2) 3) 1 0.001)
))

(test-humaneval)
