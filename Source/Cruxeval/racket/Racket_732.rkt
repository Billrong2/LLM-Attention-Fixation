#lang racket

(require racket/dict)

(define (f char_freq)
  (for/hash ([(k v) char_freq])
    (values k (quotient v 2))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("u" .  20) ("v" .  5) ("b" .  7) ("w" .  3) ("x" .  3))) #hash(("u" .  10) ("v" .  2) ("b" .  3) ("w" .  1) ("x" .  1)) 0.001)
))

(test-humaneval)
