#lang racket

(define (f nums)
  (for ([i (in-range (length nums))])
    (set! nums (append (take nums i)
                       (list (sqr (list-ref nums i)))
                       (take-right nums (- (length nums) i)))))
  nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 4)) (list 1 1 1 1 2 4) 0.001)
))

(test-humaneval)
