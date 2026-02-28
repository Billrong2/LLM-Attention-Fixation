#lang racket

(define (f input_string spaces)
  (string-copy input_string))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "a\tb" 4) "a\tb" 0.001)
))

(test-humaneval)
