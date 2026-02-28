#lang racket

(define (f nums)
  (let* ((count (length nums))
         (reversed-nums
          (for/list ((i (in-range (- count 1) -1 -1)))
            (list-ref nums i))))
    reversed-nums))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 -5 -4)) (list -4 -5 0) 0.001)
))

(test-humaneval)
