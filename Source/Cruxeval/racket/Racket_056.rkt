#lang racket

(define (f sentence)
  (for ([c (in-string sentence)])
    (if (char->integer c)
        #t
        (error "The input sentence contains non-ASCII characters")))
  #t)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "1z1z1") #t 0.001)
))

(test-humaneval)
