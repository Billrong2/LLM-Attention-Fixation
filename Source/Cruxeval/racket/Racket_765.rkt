#lang racket

(define (f text)
    (for/sum ((c (in-string text)))
        (if (char-numeric? c) 1 0)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "so456") 3 0.001)
))

(test-humaneval)
