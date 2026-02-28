#lang racket

(define (f text tab-size)
  (define tab (make-string tab-size #\space))
  (string-replace text "\t" tab))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "a" 100) "a" 0.001)
))

(test-humaneval)
