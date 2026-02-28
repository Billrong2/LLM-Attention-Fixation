#lang racket

(define (f text)
  (for/or ([i (in-range (string-length text))]
           #:when (string-prefix? "two" (substring text 0 i)))
    (substring text i))
  "no")
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "2two programmers") "no" 0.001)
))

(test-humaneval)
