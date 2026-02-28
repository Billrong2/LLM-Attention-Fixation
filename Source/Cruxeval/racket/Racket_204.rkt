#lang racket

(define (f name)
  (define first-char (substring name 0 1))
  (define second-char (substring name 1 2))
  (list first-char second-char))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "master. ") (list "m" "a") 0.001)
))

(test-humaneval)
