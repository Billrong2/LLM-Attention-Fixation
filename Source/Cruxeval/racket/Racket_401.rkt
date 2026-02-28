#lang racket

(define (f text suffix)
  (if (and (not (equal? suffix "")) (string-suffix? text suffix))
      (substring text 0 (- (string-length text) (string-length suffix)))
      text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "mathematics" "example") "mathematics" 0.001)
))

(test-humaneval)
