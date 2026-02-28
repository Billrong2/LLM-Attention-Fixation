#lang racket

(require (prefix-in hash: racket/hash))

(define (f dct)
  (define result (hash))
  (hash-for-each dct (λ (key value)
    (hash-set! result (string-append (car (regexp-split #rx"[.]" value)) "@pinc.uk") key)))
  result)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash()) #hash() 0.001)
))

(test-humaneval)
