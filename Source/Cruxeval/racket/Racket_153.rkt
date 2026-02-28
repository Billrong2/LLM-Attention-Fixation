#lang racket

(define (f text suffix num)
    (define str_num (number->string num))
    (string-suffix? text (string-append suffix str_num)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "friends and love" "and" 3) #f 0.001)
))

(test-humaneval)
