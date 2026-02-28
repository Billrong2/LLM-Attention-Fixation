#lang racket

(define (f text)
  (define counter 0)
  (for ([char (in-string text)])
    (when (char-alphabetic? char)
      (set! counter (+ counter 1))))
  counter)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "l000*") 1 0.001)
))

(test-humaneval)
