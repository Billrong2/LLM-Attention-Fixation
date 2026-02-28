#lang racket

(define (f text chunks)
    (regexp-split #rx"\n" text chunks))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "/alcm@ an)t//eprw)/e!/d
ujv" 0) (list "/alcm@ an)t//eprw)/e!/d" "ujv") 0.001)
))

(test-humaneval)
