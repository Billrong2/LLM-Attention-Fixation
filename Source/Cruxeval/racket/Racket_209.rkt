#lang racket

(define (f prefix s)
  (string-trim prefix s))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "hymi" "hymifulhxhzpnyihyf") "hymi" 0.001)
))

(test-humaneval)
