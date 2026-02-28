#lang racket

(define (f string)
  (string=? string (string-upcase string)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Ohno") #f 0.001)
))

(test-humaneval)
