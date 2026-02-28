#lang racket

(define (f text)
  (not (ormap char-upper-case? (string->list text))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "lunabotics") #t 0.001)
))

(test-humaneval)
