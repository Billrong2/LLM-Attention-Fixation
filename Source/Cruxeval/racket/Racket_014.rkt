#lang racket

(define (f s)
  (define arr (reverse (string->list (string-trim s))))
  (list->string arr))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "   OOP   ") "POO" 0.001)
))

(test-humaneval)
