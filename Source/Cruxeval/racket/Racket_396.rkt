#lang racket

(define (f ets)
  (for/hasheq ([(k v) ets])
    (set! ets (hash-set ets k (expt v 2))))
  ets)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash()) #hash() 0.001)
))

(test-humaneval)
