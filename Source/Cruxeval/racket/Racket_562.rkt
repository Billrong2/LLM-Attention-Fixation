#lang racket

(define (f text)
    (string=? (string-upcase text) text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "VTBAEPJSLGAHINS") #t 0.001)
))

(test-humaneval)
