#lang racket

(define (f nums p)
  (define prev_p (if (< (- p 1) 0) (- (length nums) 1) (- p 1)))
  (list-ref nums prev_p))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 6 8 2 5 3 1 9 7) 6) 1 0.001)
))

(test-humaneval)
