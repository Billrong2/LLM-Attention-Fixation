#lang racket

(define (f d)
  d)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("a" .  42) ("b" .  1337) ("c" .  -1) ("d" .  5))) #hash(("a" .  42) ("b" .  1337) ("c" .  -1) ("d" .  5)) 0.001)
))

(test-humaneval)
