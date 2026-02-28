#lang racket

(define (f text)
  (if (regexp-match? #px"^[a-zA-Z_][a-zA-Z0-9_]*$" text)
      (list->string (filter char-numeric? (string->list text)))
      (list->string (string->list text))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "816") "816" 0.001)
))

(test-humaneval)
