#lang racket

(define (f num)
  (define s (make-string 10 #\<))
  (if (even? num)
      s
      (- num 1)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 21) 20 0.001)
))

(test-humaneval)
