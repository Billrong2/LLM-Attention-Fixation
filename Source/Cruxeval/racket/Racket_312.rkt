#lang racket

(define (f s)
  (if (string->number s 10)
      "True"
      "False"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "777") "True" 0.001)
))

(test-humaneval)
