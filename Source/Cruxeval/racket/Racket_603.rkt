#lang racket

(define (f sentences)
  (if (andmap string->number (string-split sentences "."))
      "oscillating"
      "not oscillating"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "not numbers") "not oscillating" 0.001)
))

(test-humaneval)
