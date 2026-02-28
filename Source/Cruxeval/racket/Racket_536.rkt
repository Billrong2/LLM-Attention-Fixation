#lang racket

(define (f cat)
  (define digits 0)
  (for ([char (in-string cat)])
    (when (char-numeric? char)
      (set! digits (+ digits 1))))
  digits)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "C24Bxxx982ab") 5 0.001)
))

(test-humaneval)
