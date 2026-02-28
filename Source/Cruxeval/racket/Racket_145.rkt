#lang racket

(define (f price product)
  (define inventory '(olives key orange))
  (cond
    [(not (member product inventory))
     price]
    [else
     (set! price (* price 0.85))
     (set! inventory (remove product inventory))
     price]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 8.5 "grapes") 8.5 0.001)
))

(test-humaneval)
