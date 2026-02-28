#lang racket

(define (f text)
    (define number 0)
    (for ([t (in-string text)])
        (when (char-numeric? t)
            (set! number (+ number 1))))
    number)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Thisisastring") 0 0.001)
))

(test-humaneval)
