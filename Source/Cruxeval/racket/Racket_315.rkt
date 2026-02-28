#lang racket

(define (f challenge)
    (string-replace (string-downcase challenge) "l" ","))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "czywZ") "czywz" 0.001)
))

(test-humaneval)
