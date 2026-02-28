#lang racket

(define (f string)
  (let loop ([s string])
    (cond
      [(string=? s "") ""]
      [(char-alphabetic? (string-ref s (- (string-length s) 1))) s]
      [else (loop (substring s 0 (- (string-length s) 1)))])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "--4/0-209") "" 0.001)
))

(test-humaneval)
