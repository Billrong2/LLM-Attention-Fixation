#lang racket

(define (f nums odd1 odd2)
  (define (remove-odd lst odd)
    (if (member odd lst)
        (remove-odd (remove odd lst) odd)
        lst))
  (remove-odd (remove-odd nums odd1) odd2))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3 7 7 6 8 4 1 2 3 5 1 3 21 1 3) 3 1) (list 2 7 7 6 8 4 2 5 21) 0.001)
))

(test-humaneval)
