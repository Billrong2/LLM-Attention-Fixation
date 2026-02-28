#lang racket

(define (f nums pos)
  (define s (if (odd? pos) (- (length nums) 1) (length nums)))
  (define reversed-nums (reverse (take nums s)))
  (append reversed-nums (drop nums s)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 6 1) 3) (list 6 1) 0.001)
))

(test-humaneval)
