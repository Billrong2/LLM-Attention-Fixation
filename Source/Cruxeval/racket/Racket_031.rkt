#lang racket

(define (f string)
  (define upper 0)
  (for ([c (in-string string)])
    (when (char-upper-case? c)
      (set! upper (+ upper 1))))
  (* upper (vector-ref #(2 1) (modulo upper 2))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "PoIOarTvpoead") 8 0.001)
))

(test-humaneval)
