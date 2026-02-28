#lang racket

(define (f obj)
  (for/fold ([new-obj obj])
           ([(k v) (in-dict obj)])
    (if (>= v 0)
        (hash-set new-obj k (- v))
        new-obj)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("R" .  0) ("T" .  3) ("F" .  -6) ("K" .  0))) #hash(("R" .  0) ("T" .  -3) ("F" .  -6) ("K" .  0)) 0.001)
))

(test-humaneval)
