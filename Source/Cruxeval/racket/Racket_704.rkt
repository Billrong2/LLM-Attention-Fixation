#lang racket

(define (f s n c)
  (define width (* (string-length c) n))
  (for ([_ (in-range (- width (string-length s)))])
    (set! s (string-append c s)))
  s)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "." 0 "99") "." 0.001)
))

(test-humaneval)
