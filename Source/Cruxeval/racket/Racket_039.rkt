#lang racket

(define (f array elem)
  (define result (member elem array))
  (if result
      (- (length array) (length result))
      -1))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 6 2 7 1) 6) 0 0.001)
))

(test-humaneval)
