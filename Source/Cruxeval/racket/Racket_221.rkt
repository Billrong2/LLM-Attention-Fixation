#lang racket

(define (f text delim)
  (define parts (string-split (string-append text delim) delim))
  (string-append (second parts) delim (first parts)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "bpxa24fc5." ".") ".bpxa24fc5" 0.001)
))

(test-humaneval)
