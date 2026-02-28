#lang racket

(define (f chemicals num)
  (define fish (cdr chemicals))
  (define rev-chemicals (reverse chemicals))
  (for ([i (in-range num)])
    (set! fish (cons (list-ref rev-chemicals i) fish)))
  (reverse rev-chemicals))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "lsi" "s" "t" "t" "d") 0) (list "lsi" "s" "t" "t" "d") 0.001)
))

(test-humaneval)
