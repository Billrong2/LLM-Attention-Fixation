#lang racket

(define (f s n)
  (if (< (string-length s) n)
      s
      (substring s n)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "try." 5) "try." 0.001)
))

(test-humaneval)
