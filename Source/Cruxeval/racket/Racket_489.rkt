#lang racket

(define (f text value)
    (substring text (string-length value)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "coscifysu" "cos") "cifysu" 0.001)
))

(test-humaneval)
