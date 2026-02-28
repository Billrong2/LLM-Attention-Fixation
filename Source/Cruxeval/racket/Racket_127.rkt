#lang racket

(define (f text)
    (define s (string-split text "\n"))
    (length s))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "145

12fjkjg") 3 0.001)
))

(test-humaneval)
