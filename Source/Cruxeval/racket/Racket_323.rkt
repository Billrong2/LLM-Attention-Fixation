#lang racket

(define (f text)
    (length (regexp-split #rx"\n" text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ncdsdfdaaa0a1cdscsk*XFd") 1 0.001)
))

(test-humaneval)
