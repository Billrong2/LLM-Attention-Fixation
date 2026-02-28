#lang racket

(define (f haystack needle)
  (define index (for/or ([i (in-range (string-length haystack) -1 -1)])
                  (if (equal? (substring haystack i) needle)
                      i
                      #f)))
  (if index
      index
      -1))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "345gerghjehg" "345") -1 0.001)
))

(test-humaneval)
