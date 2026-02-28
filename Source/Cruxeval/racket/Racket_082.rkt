#lang racket

(define (f a b c d)
    (if a
        b
        (if c
            d
            #f)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "CJU" "BFS" "WBYDZPVES" "Y") "BFS" 0.001)
))

(test-humaneval)
