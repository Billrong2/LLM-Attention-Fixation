#lang racket

(define (f text char replace)
    (string-replace text char replace))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "a1a8" "1" "n2") "an2a8" 0.001)
))

(test-humaneval)
