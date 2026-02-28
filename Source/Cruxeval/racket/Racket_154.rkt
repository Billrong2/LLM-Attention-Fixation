#lang racket

(define (f s c)
  (define s-list (string-split s " "))
  (string-append c "  " (string-join (reverse s-list) "  ")))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Hello There" "*") "*  There  Hello" 0.001)
))

(test-humaneval)
