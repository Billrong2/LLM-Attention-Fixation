#lang racket

(define (f text suffix)
    (if (string-prefix? "/" suffix)
        (string-append text (substring suffix 1))
        text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "hello.txt" "/") "hello.txt" 0.001)
))

(test-humaneval)
