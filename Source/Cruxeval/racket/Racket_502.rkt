#lang racket

(define (f name)
    (string-join (string-split name " ") "*"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Fred Smith") "Fred*Smith" 0.001)
))

(test-humaneval)
