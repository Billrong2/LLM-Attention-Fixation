#lang racket

(define (f dict)
  (define even-keys '())
  (for ([key (in-list (hash-keys dict))])
    (when (= (remainder key 2) 0)
      (set! even-keys (append even-keys (list key))))
    )
  even-keys)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash((4 .  "a"))) (list 4) 0.001)
))

(test-humaneval)
