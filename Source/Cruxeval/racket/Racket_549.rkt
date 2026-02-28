#lang racket

(define (f matrix)
  (set! matrix (reverse matrix))
  (define result '())
  (for ([primary (in-list matrix)])
    (set! primary (sort primary >))
    (set! result (cons primary result)))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list (list 1 1 1 1))) (list (list 1 1 1 1)) 0.001)
))

(test-humaneval)
