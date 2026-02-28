#lang racket

(define (f input)
  (define (char-is-upper? c)
    (char-upper-case? c))
  
  (define (check-uppercase input)
    (cond
      [(empty? input) #t]
      [(char-is-upper? (string-ref input 0)) #f]
      [else (check-uppercase (substring input 1))]))
  
  (check-uppercase input))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "a j c n x X k") #f 0.001)
))

(test-humaneval)
