#lang racket

(define (f text prefix)
  (substring text (string-length prefix)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "123x John z" "z") "23x John z" 0.001)
))

(test-humaneval)
