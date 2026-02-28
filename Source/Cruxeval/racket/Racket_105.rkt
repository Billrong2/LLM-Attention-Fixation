#lang racket

(define (f text)
  (if (not (equal? (string-titlecase text) text))
      (string-titlecase text)
      (string-downcase text)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "PermissioN is GRANTed") "Permission Is Granted" 0.001)
))

(test-humaneval)
