#lang racket

(define (f seq v)
  (let ((a '()))
    (for ((i seq))
      (when (string-suffix? v i)
        (set! a (cons (string-append i i) a))))
    (reverse a)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "oH" "ee" "mb" "deft" "n" "zz" "f" "abA") "zz") (list "zzzz") 0.001)
))

(test-humaneval)
