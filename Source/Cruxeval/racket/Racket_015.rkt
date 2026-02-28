#lang racket

(define (f text wrong right)
  (define new-text (string-upcase (string-replace text wrong right)))
  new-text)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "zn kgd jw lnt" "h" "u") "ZN KGD JW LNT" 0.001)
))

(test-humaneval)
