#lang racket

(require srfi/13)

(define (f text search)
  (string-contains-ci text search))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "car hat" "car") 0 0.001)
))

(test-humaneval)
