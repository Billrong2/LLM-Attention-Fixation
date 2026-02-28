#lang racket

(define (f text)
  (define s (regexp-match #px"(.*)o(.*)" text))
  (if s
      (let ((div (if (eq? (second s) "") "-" (second s)))
            (div2 (if (eq? (third s) "") "-" (third s))))
        (string-append (fourth s) div div (fourth s) div2))
      (string-append "-" text)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "kkxkxxfck") "-kkxkxxfck" 0.001)
))

(test-humaneval)
