#lang racket

(define (f s)
    (string-replace (string-replace s "(" "[") ")" "]"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "(ac)") "[ac]" 0.001)
))

(test-humaneval)
