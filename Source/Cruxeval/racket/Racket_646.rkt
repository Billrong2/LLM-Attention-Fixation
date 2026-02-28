#lang racket

(define (f text count)
  (define (reverse-text txt)
    (list->string (reverse (string->list txt))))
  
  (let loop ((txt text) (n count))
    (if (zero? n)
        txt
        (loop (reverse-text txt) (- n 1)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "aBc, ,SzY" 2) "aBc, ,SzY" 0.001)
))

(test-humaneval)
