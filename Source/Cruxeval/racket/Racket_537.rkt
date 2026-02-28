#lang racket

(define (f text value)
  (define new-text (string->list text))
  (with-handlers ([exn:fail:contract? (lambda (exn) 0)])
    (set! new-text (append new-text (list value)))
    (string-append "[" (number->string (length new-text)) "]")))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abv" "a") "[4]" 0.001)
))

(test-humaneval)
