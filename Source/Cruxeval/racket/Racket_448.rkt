#lang racket

(define (f text suffix)
  (if (equal? suffix "")
      #f
      (string-suffix? suffix text)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "uMeGndkGh" "kG") #f 0.001)
))

(test-humaneval)
