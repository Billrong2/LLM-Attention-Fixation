#lang racket

(define (f text num_digits)
  (define width (max 1 num_digits))
  (string-append (make-string (- width (string-length text)) #\0) text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "19" 5) "00019" 0.001)
))

(test-humaneval)
