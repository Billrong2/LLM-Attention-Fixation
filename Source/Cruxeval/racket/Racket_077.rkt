#lang racket

(define (f text character)
  (define subject (substring text (string-length (substring text 0 (string-length text))) (string-length text)))
  (string-append subject subject))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "h ,lpvvkohh,u" "i") "" 0.001)
))

(test-humaneval)
