#lang racket

(define (f text ch)
  (length (regexp-match* (format "~a" ch) text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "This be Pirate's Speak for 'help'!" " ") 5 0.001)
))

(test-humaneval)
