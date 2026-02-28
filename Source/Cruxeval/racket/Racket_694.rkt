#lang racket

(require racket/dict)

(define (f d)
  (define i (- (dict-count d) 1))
  (define key (list-ref (dict-keys d) i))
  (define new-d (dict-remove d key))
  (list key new-d))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("e" .  1) ("d" .  2) ("c" .  3))) (list "c" #hash(("e" .  1) ("d" .  2))) 0.001)
))

(test-humaneval)
