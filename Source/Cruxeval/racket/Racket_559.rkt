#lang racket

(define (f n)
  (string-append (substring n 0 1) "." (string-replace (substring n 1) "-" "_")))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "first-second-third") "f.irst_second_third" 0.001)
))

(test-humaneval)
