#lang racket

(define (f s amount)
  (string-append (make-string (- amount (string-length s)) #\z) s))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abc" 8) "zzzzzabc" 0.001)
))

(test-humaneval)
