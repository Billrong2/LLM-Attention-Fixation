#lang racket

(define (f nums)
  (for/list ([i (in-range (sub1 (length nums)) -1 -1)])
    (when (odd? (list-ref nums i))
      (set! nums (append (take nums (add1 i))
                         (list (list-ref nums i))
                         (drop nums (add1 i))))))
  nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 2 3 4 6 -2)) (list 2 3 3 4 6 -2) 0.001)
))

(test-humaneval)
