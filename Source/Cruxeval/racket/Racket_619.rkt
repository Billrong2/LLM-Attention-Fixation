#lang racket

(define (f title)
    (string-downcase title))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "   Rock   Paper   SCISSORS  ") "   rock   paper   scissors  " 0.001)
))

(test-humaneval)
