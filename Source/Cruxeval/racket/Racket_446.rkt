#lang racket

(define (f array)
  (define l (length array))
  (if (even? l)
      (list)
      (reverse array)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list )) (list ) 0.001)
))

(test-humaneval)
