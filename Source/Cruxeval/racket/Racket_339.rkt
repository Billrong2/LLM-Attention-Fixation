#lang racket

(define (f array elem)
  (define d 0)
  (for ([i array])
    (when (equal? (number->string i) (number->string elem))
      (set! d (+ d 1))))
  d)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -1 2 1 -8 -8 2) 2) 2 0.001)
))

(test-humaneval)
