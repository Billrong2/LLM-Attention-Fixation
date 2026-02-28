#lang racket

(define (f text)
  (define my-list (string-split text))
  (define sorted-list (sort my-list string>?))
  (string-join sorted-list " "))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "a loved") "loved a" 0.001)
))

(test-humaneval)
