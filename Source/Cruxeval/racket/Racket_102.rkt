#lang racket

(define (f names winners)
    (define ls (sort (filter (lambda (name) (member name winners)) names) >))
    (map (lambda (name) (index-of names name)) ls))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "e" "f" "j" "x" "r" "k") (list "a" "v" "2" "im" "nb" "vj" "z")) (list ) 0.001)
))

(test-humaneval)
