#lang racket

(define (f doc)
    (for/first ([x (in-string doc)])
        (if (char-alphabetic? x)
            (string-upcase (string x))
            "-")))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "raruwa") "R" 0.001)
))

(test-humaneval)
