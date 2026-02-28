#lang racket

(define (f string prefix)
  (if (string-prefix? prefix string)
      (substring string (string-length prefix) (string-length string))
      string))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Vipra" "via") "Vipra" 0.001)
))

(test-humaneval)
