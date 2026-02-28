#lang racket

(define (f letters)
  (define letters_only (string-trim letters #px"[., !?*]"))
  (string-join (string-split letters_only " ") "...."))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "h,e,l,l,o,wo,r,ld,") "h,e,l,l,o,wo,r,ld" 0.001)
))

(test-humaneval)
