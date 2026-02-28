#lang racket

(define (f nums i)
    (define new-nums (remove-at nums i))
    new-nums)

(define (remove-at lst n)
    (append (take lst n) (drop lst (+ n 1))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 35 45 3 61 39 27 47) 0) (list 45 3 61 39 27 47) 0.001)
))

(test-humaneval)
