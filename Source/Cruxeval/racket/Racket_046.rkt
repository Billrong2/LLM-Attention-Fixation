#lang racket

(define (f l c)
    (string-join l c))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "many" "letters" "asvsz" "hello" "man") "") "manylettersasvszhelloman" 0.001)
))

(test-humaneval)
