#lang racket

(define (f text)
    (if (string=? (string-upcase text) text)
        "ALL UPPERCASE"
        text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Hello Is It MyClass") "Hello Is It MyClass" 0.001)
))

(test-humaneval)
