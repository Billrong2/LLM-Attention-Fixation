#lang racket

(define (f txt)
  (define d '())
  (for ([c (in-string txt)])
    (cond
      [(char-numeric? c) #t]
      [(char-lower-case? c) (set! d (append d (list (char-upcase c))))]
      [(char-upper-case? c) (set! d (append d (list (char-downcase c))))]))
  (list->string d))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "5ll6") "LL" 0.001)
))

(test-humaneval)
