#lang racket

(define (f lst)
  (define new '())
  (define i (- (length lst) 1))
  (for ([_ (in-range (length lst))])
    (if (= (remainder i 2) 0)
        (set! new (append new (list (- (list-ref lst i)))))
        (set! new (append new (list (list-ref lst i))))
    )
    (set! i (- i 1))
  )
  new
)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 7 -1 -3)) (list -3 1 7 -1) 0.001)
))

(test-humaneval)
