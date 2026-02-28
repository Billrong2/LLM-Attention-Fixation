#lang racket

(define (f t)
  (define (is-numeric c)
    (char-numeric? c))
  
  (define (check-characters lst)
    (cond
      [(empty? lst) #t]
      [(is-numeric (first lst)) (check-characters (rest lst))]
      [else #f]))
  
  (check-characters (string->list t)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "#284376598") #f 0.001)
))

(test-humaneval)
