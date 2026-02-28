#lang racket

(define (f text x)
  (if (equal? (string-trim text x) text)
      (f (substring text 1) x)
      text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Ibaskdjgblw asdl " "djgblw") "djgblw asdl " 0.001)
))

(test-humaneval)
