#lang racket

(require srfi/13) ;; for string-join

(define (f text ch)
  (define result '())
  (for ([line (in-list (string-split text "\n"))])
    (if (and (> (string-length line) 0) (string=? (substring line 0 1) ch))
        (set! result (cons (string-downcase line) result))
        (set! result (cons (string-upcase line) result))))
  (string-join (reverse result) "\n"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "t
za
a" "t") "t
ZA
A" 0.001)
))

(test-humaneval)
