#lang racket

(define (f a b)
  (if (string<? a b)
      (list b a)
      (list a b)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ml" "mv") (list "mv" "ml") 0.001)
))

(test-humaneval)
