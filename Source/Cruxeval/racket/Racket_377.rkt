#lang racket

(define (f text)
  (string-join (string-split text "\n") ", "))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "BYE
NO
WAY") "BYE, NO, WAY" 0.001)
))

(test-humaneval)
