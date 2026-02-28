#lang racket

(define (f x)
  (define reversed-list (reverse (string->list x)))
  (string-join (map string reversed-list) " "))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "lert dna ndqmxohi3") "3 i h o x m q d n   a n d   t r e l" 0.001)
))

(test-humaneval)
