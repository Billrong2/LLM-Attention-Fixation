#lang racket

(define (f lst)
  (set! lst '())
  (let ([new-lst (build-list (add1 (length lst)) (lambda (_) 1))])
    (set! lst new-lst))
  lst)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "a" "c" "v")) (list 1) 0.001)
))

(test-humaneval)
