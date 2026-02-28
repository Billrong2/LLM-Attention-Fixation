#lang racket

(define (f text value)
    (define length (string-length text))
    (define index 0)
    (define (loop text value length index)
        (if (> length 0)
            (loop text (string-append (substring text index (+ index 1)) value) (- length 1) (+ index 1))
            value))
    (loop text value length index))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "jao mt" "house") "tm oajhouse" 0.001)
))

(test-humaneval)
