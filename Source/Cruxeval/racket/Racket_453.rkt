#lang racket

(define (f string c)
    (string-suffix? string c))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "wrsch)xjmb8" "c") #f 0.001)
))

(test-humaneval)
