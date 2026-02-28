#lang racket

(define (f text)
  (for ([i (in-range 10 0 -1)])
    (set! text (regexp-replace (regexp (string-append "^" (number->string i))) text "")))
  text)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "25000   $") "5000   $" 0.001)
))

(test-humaneval)
