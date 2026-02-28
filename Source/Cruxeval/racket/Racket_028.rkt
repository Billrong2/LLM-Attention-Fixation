#lang racket

(define (f mylist)
  (define revl (reverse mylist))
  (set! mylist (sort mylist >))
  (equal? mylist revl))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 5 8)) #t 0.001)
))

(test-humaneval)
