#lang racket

(define (f text)
  (define text-upper (string-upcase text))
  (define count_upper 0)
  (for ([char (in-string text-upper)])
    (if (char-upper-case? char)
        (set! count_upper (+ count_upper 1))
        "no"))
  (floor (/ count_upper 2)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ax") 1 0.001)
))

(test-humaneval)
