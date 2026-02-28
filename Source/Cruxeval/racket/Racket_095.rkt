#lang racket

(define (f zoo)
  (for/hash ([(k v) zoo])
    (values v k)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("AAA" .  "fr"))) #hash(("fr" .  "AAA")) 0.001)
))

(test-humaneval)
