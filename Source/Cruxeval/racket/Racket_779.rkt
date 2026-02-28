#lang racket

(define (f text)
  (match-let ([(list first second third fourth) (string-split text)])
    (string-append "${first}y, ${second}x, ${third}r, ${fourth}p")))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "python ruby c javascript") "${first}y, ${second}x, ${third}r, ${fourth}p" 0.001)
))

(test-humaneval)
