#lang racket

(define (f name)
    (string-append "| " (string-join (string-split name " ") " ") " |"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "i am your father") "| i am your father |" 0.001)
))

(test-humaneval)
