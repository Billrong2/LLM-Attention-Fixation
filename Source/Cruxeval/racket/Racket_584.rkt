#lang racket

(define (f txt)
  txt)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "5123807309875480094949830") "5123807309875480094949830" 0.001)
))

(test-humaneval)
