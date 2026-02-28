#lang racket

(define (f nums)
    (define reversed-nums (reverse nums))
    (string-join (map number->string reversed-nums) ""))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -1 9 3 1 -2)) "-2139-1" 0.001)
))

(test-humaneval)
