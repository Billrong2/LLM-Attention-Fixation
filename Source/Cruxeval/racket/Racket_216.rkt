#lang racket

(define (f letters)
  (define count 0)
  (for ([l (in-string letters)])
    (when (char-numeric? l)
      (set! count (+ count 1))))
  count)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "dp ef1 gh2") 2 0.001)
))

(test-humaneval)
