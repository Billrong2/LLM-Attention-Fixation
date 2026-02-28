#lang racket

(define (f text sep)
  (define result (regexp-split (regexp sep) text))
  (if (> (length result) 3)
      (take result 3)
      result))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "a-.-.b" "-.") (list "a" "" "b") 0.001)
))

(test-humaneval)
