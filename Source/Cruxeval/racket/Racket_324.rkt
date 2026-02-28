#lang racket

(define (f nums)
  (define asc (reverse nums))
  (define desc (take asc (quotient (length asc) 2)))
  (append desc asc desc))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list )) (list ) 0.001)
))

(test-humaneval)
