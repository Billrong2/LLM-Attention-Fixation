#lang racket

(require (only-in racket/list argmax))

(define (f d)
  (let* ([keys (sort (hash-keys d) >)]
         [key1 (first keys)]
         [val1 (hash-ref d key1)]
         [key2 (second keys)]
         [val2 (hash-ref d key2)])
    (hash key1 val1 key2 val2)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash((2 .  3) (17 .  3) (16 .  6) (18 .  6) (87 .  7))) #hash((87 .  7) (18 .  6)) 0.001)
))

(test-humaneval)
