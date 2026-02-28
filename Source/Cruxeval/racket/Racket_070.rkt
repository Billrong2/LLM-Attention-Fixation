#lang racket

(require srfi/1)

(define (f x)
  (define a 0)
  (for ([i (string-split x " ")])
    (set! a (+ a (string-length (~a #:width (* 2 (string-length i)) #:pad-string "0" i)))))
  a)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "999893767522480") 30 0.001)
))

(test-humaneval)
