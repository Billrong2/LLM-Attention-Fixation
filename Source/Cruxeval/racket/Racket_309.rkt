#lang racket

(define (f text suffix)
  (define text-suffix (substring text (- (string-length text) (string-length suffix))))
  (if (equal? text-suffix suffix)
      (f (substring text 0 (- (string-length text) 1)) suffix)
      text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "faqo osax f" "f") "faqo osax " 0.001)
))

(test-humaneval)
