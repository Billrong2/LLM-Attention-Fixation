#lang racket

(define (f text)
  (if (string->bytes/utf-8 text)
      "ascii"
      "non ascii"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "<<<<") "ascii" 0.001)
))

(test-humaneval)
