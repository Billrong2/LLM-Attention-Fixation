#lang racket

(define (f nums)
  (if (equal? (reverse nums) nums)
      #t
      #f))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 3 6 2)) #f 0.001)
))

(test-humaneval)
