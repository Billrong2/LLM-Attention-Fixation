#lang racket

(define (f string)
  (if (string=? (substring string 0 4) "Nuva")
      string
      "no"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Nuva?dlfuyjys") "Nuva?dlfuyjys" 0.001)
))

(test-humaneval)
