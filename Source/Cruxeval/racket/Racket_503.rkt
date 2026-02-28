#lang racket

(define (f d)
  (let ([result (make-vector (hash-count d) #f)]
        [len (hash-count d)])
    (define a 0)
    (define b 0)
    (for ([i (in-hash-keys d)])
      (vector-set! result a (cons i (hash-ref d i)))
      (set! a b)
      (set! b (modulo (add1 b) len)))
    (vector->list result)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash()) (list ) 0.001)
))

(test-humaneval)
