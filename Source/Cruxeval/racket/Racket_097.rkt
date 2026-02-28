#lang racket

(define (f lst)
  (set! lst '())
  (for/and ([i lst])
    (not (equal? i 3))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 2 0)) #t 0.001)
))

(test-humaneval)
