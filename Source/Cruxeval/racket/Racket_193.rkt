#lang racket

(define (f string)
  (define count (regexp-match* #rx":" string))
  (define count-length (length count))
  (if (> count-length 1)
      (let loop ([s string] [n (- count-length 1)])
        (if (= n 0)
            s
            (loop (regexp-replace #rx":" s "") (- n 1))))
      string))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "1::1") "1:1" 0.001)
))

(test-humaneval)
