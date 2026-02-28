#lang racket

(define (f num name)
  (format "quiz leader = ~a, count = ~a" name num))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 23 "Cornareti") "quiz leader = Cornareti, count = 23" 0.001)
))

(test-humaneval)
