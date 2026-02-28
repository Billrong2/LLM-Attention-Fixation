#lang racket

(define (f text)
  (length (regexp-match* #rx":.*" text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "#! : #!") 1 0.001)
))

(test-humaneval)
