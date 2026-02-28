#lang racket

(define (f number)
  (define number-list (string->list number))
  (for/and ([char number-list])
    (char-numeric? char)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "dummy33;d") #f 0.001)
))

(test-humaneval)
