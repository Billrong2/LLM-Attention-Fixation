#lang racket

(define (f nums fill)
  (for/hash ((num (in-list nums)))
    (values num fill)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 1 1 2) "abcca") #hash((0 .  "abcca") (1 .  "abcca") (2 .  "abcca")) 0.001)
))

(test-humaneval)
