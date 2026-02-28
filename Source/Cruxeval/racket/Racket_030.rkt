#lang racket

(define (f array)
  (for/list ([elem (in-list array)])
    (or (string->immutable-string elem)
        (number->string elem))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "a" "b" "c")) (list "a" "b" "c") 0.001)
))

(test-humaneval)
