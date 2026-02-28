#lang racket

(define (f text search)
    (and (>= (string-length search) (string-length text))
         (string=? (substring search 0 (string-length text)) text)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "123" "123eenhas0") #t 0.001)
))

(test-humaneval)
