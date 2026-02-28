#lang racket

(define (f text char)
  (odd? (count (λ (c) (char=? c (string-ref char 0))) (string->list text))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abababac" "a") #f 0.001)
))

(test-humaneval)
