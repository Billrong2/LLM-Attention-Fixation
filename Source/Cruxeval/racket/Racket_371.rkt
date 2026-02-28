#lang racket

(define (f nums)
    (define new-nums (filter (lambda (x) (not (= (remainder x 2) 1))) nums))
    (apply + new-nums))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 11 21 0 11)) 0 0.001)
))

(test-humaneval)
