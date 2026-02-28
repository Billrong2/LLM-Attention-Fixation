#lang racket

(define (f n)
  (define b (string->list (number->string n)))
  (for ([i (range 2 (sub1 (length b)))])
    (set! b (list-update b i (lambda (x) (string-append (string x) "+")))))
  (map string b))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 44) (list "4" "4") 0.001)
))

(test-humaneval)
