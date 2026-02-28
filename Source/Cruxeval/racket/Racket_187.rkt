#lang racket

(define (f d index)
  (hash-ref d (list-ref (sort (hash-keys d) <) (modulo index (hash-count d))) #f))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash((27 .  39)) 1) 39 0.001)
))

(test-humaneval)
