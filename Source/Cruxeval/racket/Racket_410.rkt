#lang racket

(define (f nums)
  (let* ((a 0)
         (len (length nums)))
    (for ([i (in-range len)])
      (set! nums (append (take nums i) (list (list-ref nums a)) (drop nums i)))
      (set! a (add1 a)))
    nums))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 3 -1 1 -2 6)) (list 1 1 1 1 1 1 1 3 -1 1 -2 6) 0.001)
))

(test-humaneval)
