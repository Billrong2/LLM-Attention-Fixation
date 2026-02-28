#lang racket

(define (f test_str)
    (define s (string-replace test_str "a" "A"))
    (string-replace s "e" "A"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "papera") "pApArA" 0.001)
))

(test-humaneval)
