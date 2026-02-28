#lang racket

(define (f d rm)
  (define res d)
  (for ([k (in-list rm)])
    (when (dict-has-key? res k)
      (set! res (hash-remove res k))))
  res)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("1" .  "a") (1 .  "a") (1 .  "b") ("1" .  "b")) (list 1)) #hash(("1" .  "b")) 0.001)
))

(test-humaneval)
