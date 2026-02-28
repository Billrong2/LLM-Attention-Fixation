#lang racket

(define (f nums)
  (define copy (hash-copy nums))
  (define newDict (hash))
  (for ([k (in-dict copy)])
    (hash-set! newDict k (length (hash-ref copy k))))
  newDict)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash()) #hash() 0.001)
))

(test-humaneval)
