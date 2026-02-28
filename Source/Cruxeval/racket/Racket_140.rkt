#lang racket

(require srfi/13)

(define (f st)
  (define st_lower (string-downcase st))
  (define index_h (string-index-right st_lower #\h))
  (define index_i (string-index-right st_lower #\i))
  (if (and index_h index_i (>= (string-index-right st_lower #\h index_i) index_i))
      "Hey"
      "Hi"))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Hi there") "Hey" 0.001)
))

(test-humaneval)
