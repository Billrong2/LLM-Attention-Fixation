#lang racket

(define (f array elem)
  (append array elem))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list (list 1 2 3) (list 1 2) 1) (list (list 1 2 3) 3 (list 2 1))) (list (list 1 2 3) (list 1 2) 1 (list 1 2 3) 3 (list 2 1)) 0.001)
))

(test-humaneval)
