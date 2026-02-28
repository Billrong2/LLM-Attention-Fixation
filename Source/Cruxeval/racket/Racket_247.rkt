#lang racket

(define (f s)
  (cond
    [(string->number s) "no"]
    [(string=? s "") "str is empty"]
    [else "yes"]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Boolean") "yes" 0.001)
))

(test-humaneval)
