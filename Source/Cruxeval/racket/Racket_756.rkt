#lang racket

(define (f text)
  (if (and (string->number text) 
           (for/and ([c (in-string text)]) 
             (char-numeric? c)))
      "integer"
      "string"))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "") "string" 0.001)
))

(test-humaneval)
