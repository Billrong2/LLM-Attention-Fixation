#lang racket

(define (f num1 num2 num3)
  (define nums (list num1 num2 num3))
  (set! nums (sort nums <))
  (string-append (number->string (first nums))
                 ","
                 (number->string (second nums))
                 ","
                 (number->string (third nums))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 6 8 8) "6,8,8" 0.001)
))

(test-humaneval)
