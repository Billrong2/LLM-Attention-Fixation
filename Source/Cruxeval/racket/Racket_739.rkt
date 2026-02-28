#lang racket

(define (f st pattern)
  (define (helper st pattern)
    (cond
      [(empty? pattern) #t]
      [(not (string-prefix? (first pattern) st)) #f]
      [else (helper (substring st (string-length (first pattern))) (rest pattern))]))
  
  (helper st pattern))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "qwbnjrxs" (list "jr" "b" "r" "qw")) #f 0.001)
))

(test-humaneval)
