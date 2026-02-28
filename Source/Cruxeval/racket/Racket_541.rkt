#lang racket

(define (f text)
    (string-contains? (string-trim text) ""))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate " 	  　") #t 0.001)
))

(test-humaneval)
