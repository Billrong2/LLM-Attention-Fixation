#lang racket

(define (f text)
  (let ((match (regexp-match-positions #rx"," text)))
    (if (null? match)
        -1
        (caar match))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "There are, no, commas, in this text") 9 0.001)
))

(test-humaneval)
