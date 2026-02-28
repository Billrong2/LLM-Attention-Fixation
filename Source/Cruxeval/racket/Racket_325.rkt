#lang racket

(define (f s)
  (define l (string->list s))
  (define (check-digit? char)
    (char-numeric? (char-downcase char)))
  (define (check-list lst)
    (cond
      [(empty? lst) #t]
      [(not (check-digit? (first lst))) #f]
      [else (check-list (rest lst))]))
  (check-list l))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "") #t 0.001)
))

(test-humaneval)
