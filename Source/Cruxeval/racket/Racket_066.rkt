#lang racket

(define (f text prefix)
  (define prefix_length (string-length prefix))
  (if (equal? (substring text 0 prefix_length) prefix)
      (substring text
                 (quotient (sub1 prefix_length) 2)
                 (quotient (sub1 prefix_length) -2))
      text))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "happy" "ha") "" 0.001)
))

(test-humaneval)
