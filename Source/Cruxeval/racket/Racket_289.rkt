#lang racket

(define (f code)
  (string-append code ": " (format "b'~a'" (string->bytes/utf-8 code))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "148") "148: b'148'" 0.001)
))

(test-humaneval)
