#lang racket

(define (f nums sort-count)
    (define sorted-nums (sort nums <))
    (take sorted-nums sort-count))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 2 3 4 5) 1) (list 1) 0.001)
))

(test-humaneval)
