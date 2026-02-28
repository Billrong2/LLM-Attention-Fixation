#lang racket

(define (f string)
  (define title-string (string-titlecase string))
  (string-replace title-string #rx" " ""))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "1oE-err bzz-bmm") "1Oe-ErrBzz-Bmm" 0.001)
))

(test-humaneval)
