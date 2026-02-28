#lang racket

(define (f nums start k)
  (begin
    (set! nums (append (take nums start) (reverse (take (drop nums start) k)) (drop nums (+ start k))))
    nums))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3 4 5 6) 4 2) (list 1 2 3 4 6 5) 0.001)
))

(test-humaneval)
