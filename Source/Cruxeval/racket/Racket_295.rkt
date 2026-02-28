#lang racket

(define (f fruits)
  (if (equal? (last fruits) (first fruits))
      '("no")
      (let ((new-fruits (cdr (reverse (cdr (reverse (cdr (reverse (cdr fruits)))))))))
        new-fruits)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "apple" "apple" "pear" "banana" "pear" "orange" "orange")) (list "pear" "banana" "pear") 0.001)
))

(test-humaneval)
