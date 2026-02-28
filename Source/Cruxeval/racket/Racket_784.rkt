#lang racket

(define (f key value)
  (let ([dict_ (make-hash (list (cons key value)))])
    (hash-remove! dict_ key)
    (list key value)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "read" "Is") (list "read" "Is") 0.001)
))

(test-humaneval)
