#lang racket

(define (f text)
  (define uppers (for/sum ([c (in-string text)])
                   (if (char-upper-case? c) 1 0)))
  (if (>= uppers 10)
      (string-upcase text)
      text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "?XyZ") "?XyZ" 0.001)
))

(test-humaneval)
