#lang racket

(define (f text)
  (regexp-replace #rx"$" text "#"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "the cow goes moo") "the cow goes moo#" 0.001)
))

(test-humaneval)
