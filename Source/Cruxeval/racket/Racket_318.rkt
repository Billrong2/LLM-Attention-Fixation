#lang racket

(define (f value char)
  (define total 0)
  (for ([c (in-string value)])
    (when (or (equal? c char) (equal? (string-downcase (string c)) char))
      (set! total (+ total 1))))
  total)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "234rtccde" "e") 1 0.001)
))

(test-humaneval)
