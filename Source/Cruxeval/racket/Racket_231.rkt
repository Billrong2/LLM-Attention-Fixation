#lang racket

(define (f years)
  (define a10 (length (filter (lambda (x) (<= x 1900)) years)))
  (define a90 (length (filter (lambda (x) (> x 1910)) years)))
  (cond
    [(> a10 3) 3]
    [(> a90 3) 1]
    [else 2]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1872 1995 1945)) 2 0.001)
))

(test-humaneval)
