#lang racket

(define (f strings substr)
  (define list (filter (lambda (s) (string-prefix? substr s)) strings))
  (sort list < #:key string-length))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "condor" "eyes" "gay" "isa") "d") (list ) 0.001)
))

(test-humaneval)
