#lang racket

(require (only-in racket/list argmax))

(define (f seq value)
  (define roles (for/hash ([s (in-list seq)])
                 (values s "north")))
  (when (not (string=? value ""))
    (for ([k (in-list (string-split value #\,))])
      (hash-set! roles (string-trim k) "north")))
  roles)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "wise king" "young king") "") #hash(("wise king" .  "north") ("young king" .  "north")) 0.001)
))

(test-humaneval)
