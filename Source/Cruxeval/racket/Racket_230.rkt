#lang racket

(require (only-in racket string->list))

(define (f text)
  (define result "")
  (define i (sub1 (string-length text)))
  (let loop ()
    (define c (string-ref text i))
    (when (char-alphabetic? c)
      (set! result (string-append result (string c))))
    (set! i (sub1 i))
    (when (>= i 0)
      (loop)))
  result)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "102x0zoq") "qozx" 0.001)
))

(test-humaneval)
