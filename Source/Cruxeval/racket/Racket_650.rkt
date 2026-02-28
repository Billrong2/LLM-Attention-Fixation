#lang racket

(require rackunit)

(define (f string substring)
  (let loop ([s string])
    (if (string-prefix? s substring)
        (loop (substring s (string-length substring)))
        s)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "" "A") "" 0.001)
))

(test-humaneval)
