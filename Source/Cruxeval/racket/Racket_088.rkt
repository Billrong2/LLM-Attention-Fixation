#lang racket

(define (f s1 s2)
  (if (string-suffix? s1 s2)
      (substring s2 0 (- (string-length s2) (string-length s1)))
      s2))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "he" "hello") "hello" 0.001)
))

(test-humaneval)
