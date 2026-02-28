#lang racket

(define (f s)
  (string-replace (string-replace s "a" "") "r" ""))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "rpaar") "p" 0.001)
))

(test-humaneval)
