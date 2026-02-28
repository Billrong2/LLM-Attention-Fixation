#lang racket

(define (f nums)
  (let ((count (length nums)))
    (for/list ((i (in-range count)))
      (set! nums (cons (* 2 (list-ref nums i)) nums)))
    nums))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 2 8 -2 9 3 3)) (list 4 4 4 4 4 4 2 8 -2 9 3 3) 0.001)
))

(test-humaneval)
