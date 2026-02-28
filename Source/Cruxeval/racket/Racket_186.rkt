#lang racket

(define (f text)
  (string-join (map (lambda (s) (regexp-replace #rx"^ +" s "")) (string-split text)) " "))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "pvtso") "pvtso" 0.001)
))

(test-humaneval)
