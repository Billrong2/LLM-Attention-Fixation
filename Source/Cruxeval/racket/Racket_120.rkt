#lang racket

(define (f countries)
  (define language-country (hash))
  (for ([pair (in-hash countries)])
    (define country (car pair))
    (define language (cdr pair))
    (define lst (hash-ref language-country language '()))
    (hash-set! language-country language (cons country lst)))
  language-country)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash()) #hash() 0.001)
))

(test-humaneval)
