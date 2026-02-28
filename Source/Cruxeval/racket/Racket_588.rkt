#lang racket

(define (f items target)
  (define res (member target items))
  (if res
      (sub1 (length res))
      -1))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "1" "+" "-" "**" "//" "*" "+") "**") 3 0.001)
))

(test-humaneval)
