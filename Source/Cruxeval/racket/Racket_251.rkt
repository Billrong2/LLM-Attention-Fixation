#lang racket

(define (f messages)
  (define phone_code '("+" "3" "5" "3"))
  (define result '())
  (for ([message (in-list messages)])
    (set! message (append message phone_code))
    (set! result (append result (list (string-join message ";")))))
  (string-join result ". "))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list (list "Marie" "Nelson" "Oscar"))) "Marie;Nelson;Oscar;+;3;5;3" 0.001)
))

(test-humaneval)
