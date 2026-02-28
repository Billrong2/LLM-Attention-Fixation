#lang racket

(define (f s)
  (list->string (for/list ([c (in-string s)])
               (char-downcase c))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abcDEFGhIJ") "abcdefghij" 0.001)
))

(test-humaneval)
