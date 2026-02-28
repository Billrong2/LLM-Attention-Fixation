#lang racket

(define (f a-str prefix)
  (if (string-prefix? prefix a-str)
      a-str
      (string-append prefix a-str)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abc" "abcd") "abc" 0.001)
))

(test-humaneval)
