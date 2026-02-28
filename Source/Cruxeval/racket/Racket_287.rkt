#lang racket

(define (f name)
  (define lower-name (string-downcase name))
  (define upper-name (string-upcase name))
  (if (equal? name lower-name)
      upper-name
      lower-name))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Pinneaple") "pinneaple" 0.001)
))

(test-humaneval)
