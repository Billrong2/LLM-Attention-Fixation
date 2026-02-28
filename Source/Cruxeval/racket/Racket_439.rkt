#lang racket

(define (f value)
    (define parts (string-split value " "))
    (string-join (map string-append parts) ""))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "coscifysu") "coscifysu" 0.001)
))

(test-humaneval)
