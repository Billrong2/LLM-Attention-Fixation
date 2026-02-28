#lang racket

(define (f text length index)
    (define ls (reverse (string-split text)))
    (define result (string-join (map (lambda (l) (substring l 0 length)) ls) "_"))
    result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "hypernimovichyp" 2 2) "hy" 0.001)
))

(test-humaneval)
