#lang racket

(define (f text)
  (not (string->number text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "the speed is -36 miles per hour") #t 0.001)
))

(test-humaneval)
