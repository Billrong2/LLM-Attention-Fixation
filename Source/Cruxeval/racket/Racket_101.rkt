#lang racket

(define (f array i_num elem)
    (insert-at array i_num elem))

(define (insert-at lst n elem)
    (append (take lst n) (cons elem (drop lst n))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -4 1 0) 1 4) (list -4 4 1 0) 0.001)
))

(test-humaneval)
