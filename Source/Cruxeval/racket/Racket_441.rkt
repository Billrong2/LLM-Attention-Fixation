#lang racket

(define (f base k v)
  (hash-set base k v))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash((37 .  "forty-five")) "23" "what?") #hash((37 .  "forty-five") ("23" .  "what?")) 0.001)
))

(test-humaneval)
