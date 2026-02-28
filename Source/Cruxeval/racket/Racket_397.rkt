#lang racket

(define (f ls)
  (for/hash ([i (in-list ls)])
    (values i 0)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "x" "u" "w" "j" "3" "6")) #hash(("x" .  0) ("u" .  0) ("w" .  0) ("j" .  0) ("3" .  0) ("6" .  0)) 0.001)
))

(test-humaneval)
