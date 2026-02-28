#lang racket

(define (f array)
  (define new-array (reverse array))
  (map (lambda (x) (* x x)) new-array))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 1)) (list 1 4 1) 0.001)
))

(test-humaneval)
