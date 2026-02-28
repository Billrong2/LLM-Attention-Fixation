#lang racket

(define (f text)
  (andmap char-lower-case? (string->list text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "54882") #f 0.001)
))

(test-humaneval)
