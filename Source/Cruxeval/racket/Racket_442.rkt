#lang racket

(define (f lst)
  (let ([res '()])
    (for ([i (in-range (length lst))])
      (when (even? (list-ref lst i))
        (set! res (cons (list-ref lst i) res))))
    lst))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3 4)) (list 1 2 3 4) 0.001)
))

(test-humaneval)
