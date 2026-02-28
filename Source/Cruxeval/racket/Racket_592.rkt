#lang racket

(define (f numbers)
    (define new_numbers '())
    (for ([i (in-naturals)]
          [num (in-list (reverse numbers))])
        (set! new_numbers (append new_numbers (list num))))
    new_numbers)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 11 3)) (list 3 11) 0.001)
))

(test-humaneval)
