#lang racket

(define (f n)
  (if (regexp-match? #rx"\\." n)
      (number->string (+ (string->number n) 2.5))
      n))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "800") "800" 0.001)
))

(test-humaneval)
