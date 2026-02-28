#lang racket

(define (f s n)
    (string=? (string-downcase s) (string-downcase n)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "daaX" "daaX") #t 0.001)
))

(test-humaneval)
