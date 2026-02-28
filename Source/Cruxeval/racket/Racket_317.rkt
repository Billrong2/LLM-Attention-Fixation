#lang racket

(define (f text a b)
  (define new-text (string-replace text a b))
  (string-replace new-text b a))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate " vup a zwwo oihee amuwuuw! " "a" "u") " vap a zwwo oihee amawaaw! " 0.001)
))

(test-humaneval)
