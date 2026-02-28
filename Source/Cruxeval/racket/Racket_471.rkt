#lang racket

(define (f val text)
  (define indices 
    (for/list ([index (in-range (string-length text))]
               #:when (char=? (string-ref text index) (string-ref val 0)))
      index))
  (if (null? indices)
      -1
      (car indices)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "o" "fnmart") -1 0.001)
))

(test-humaneval)
