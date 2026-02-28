#lang racket

(define (f dic)
  (define d (hash))
  (for ([key (in-dict dic)])
    (let ([value (dict-remove dic (car key))])
      (dict-set! d key value)))
  d)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash()) #hash() 0.001)
))

(test-humaneval)
