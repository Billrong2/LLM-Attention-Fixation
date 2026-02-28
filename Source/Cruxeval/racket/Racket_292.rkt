#lang racket

(define (f text)
  (define new_text
    (map (lambda (c)
           (if (char-numeric? c)
               c
               #\*))
         (string->list text)))
  (list->string new_text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "5f83u23saa") "5*83*23***" 0.001)
))

(test-humaneval)
