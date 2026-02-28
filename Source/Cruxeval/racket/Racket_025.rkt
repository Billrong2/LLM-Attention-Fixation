#lang racket

(require (only-in racket/dict dict-remove))

(define (f d)
  (dict-remove d (first (dict-keys d))))

;; test cases
(require rackunit)
(require rackunit/text-ui)

(define (test-f)
  (let ((candidate f))
    (check-equal? (candidate (hash "a" 1 "b" 2)) (hash "a" 1))))

(test-f)
```
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("l" .  1) ("t" .  2) ("x:" .  3))) #hash(("l" .  1) ("t" .  2)) 0.001)
))

(test-humaneval)
