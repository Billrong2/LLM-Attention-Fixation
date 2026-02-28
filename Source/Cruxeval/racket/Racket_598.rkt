#lang racket

(define (f text n)
  (define length (string-length text))
  (substring text (* length (modulo n 4)) length))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abc" 1) "" 0.001)
))

(test-humaneval)
