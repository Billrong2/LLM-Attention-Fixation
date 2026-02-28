#lang racket

(define (f letters maxsplit)
  (define words (string-split letters))
  (define last-words (if (< maxsplit (length words))
                        (take-right words maxsplit)
                        words))
  (apply string-append last-words))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "elrts,SS ee" 6) "elrts,SSee" 0.001)
))

(test-humaneval)
