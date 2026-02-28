#lang racket

(define (f d count)
  (define new-dict (hash))
  (for ((i (in-range count)))
    (set! new-dict (hash-copy d)))
  new-dict)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("a" .  2) ("b" .  (list )) ("c" .  #hash())) 0) #hash() 0.001)
))

(test-humaneval)
