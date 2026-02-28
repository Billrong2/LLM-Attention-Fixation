#lang racket

(define (f text value)
  (define partitioned (string-split text value))
  (string-append (second partitioned) (first partitioned)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "difkj rinpx" "k") "j rinpxdif" 0.001)
))

(test-humaneval)
