#lang racket

(require srfi/13) ; for string-trim-right

(define (f s)
  (list->string (reverse (string->list (string-trim-right s)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ab        ") "ba" 0.001)
))

(test-humaneval)
