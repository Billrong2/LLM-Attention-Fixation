#lang racket

(define (f s o)
  (if (string-prefix? s o)
      s
      (string-append o (f s (substring o (- (string-length o) 2) (string-length o))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abba" "bab") "bababba" 0.001)
))

(test-humaneval)
