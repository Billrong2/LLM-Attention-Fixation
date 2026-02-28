#lang racket

(define (f st)
    (if (equal? (substring st 0 1) "~")
        (f (string-append "s" st))
        (string-append "n" st)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "eqe-;ew22") "neqe-;ew22" 0.001)
))

(test-humaneval)
