#lang racket

(define (string-all-uppercase? str)
  (equal? str (string-upcase str)))

(define (string-all-lowercase? str)
  (equal? str (string-downcase str)))

(define (f string)
  (cond
    [(string-all-uppercase? string) (string-downcase string)]
    [(string-all-lowercase? string) (string-upcase string)]
    [else string]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "cA") "cA" 0.001)
))

(test-humaneval)
