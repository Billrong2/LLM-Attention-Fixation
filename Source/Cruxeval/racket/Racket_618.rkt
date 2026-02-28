#lang racket

(define (f match fill n)
  (string-append (substring fill 0 (min n (string-length fill))) match))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "9" "8" 2) "89" 0.001)
))

(test-humaneval)
