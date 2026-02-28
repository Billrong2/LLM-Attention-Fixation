#lang racket

(define (f arr)
  (define new-arr (list "1" "2" "3" "4"))
  (string-join new-arr ","))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 1 2 3 4)) "1,2,3,4" 0.001)
))

(test-humaneval)
