#lang racket

(define (f text)
  (define n 0)
  (for ([char (in-string text)])
    (when (char-upper-case? char)
      (set! n (+ n 1))))
  n)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "AAAAAAAAAAAAAAAAAAAA") 20 0.001)
))

(test-humaneval)
