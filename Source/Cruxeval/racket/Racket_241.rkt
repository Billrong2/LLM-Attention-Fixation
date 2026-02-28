#lang racket

(define (f postcode)
  (substring postcode (string-length "ED20 ") (string-length postcode)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ED20 CW") "CW" 0.001)
))

(test-humaneval)
