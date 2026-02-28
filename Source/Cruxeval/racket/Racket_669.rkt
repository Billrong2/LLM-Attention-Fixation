#lang racket

(define (f t)
  (define parts (regexp-split #rx"-" t))
  (define a (first parts))
  (define b (apply string-append (rest parts)))
  (if (= (string-length a) (string-length b))
      "imbalanced"
      (string-append a b)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "fubarbaz") "fubarbaz" 0.001)
))

(test-humaneval)
