#lang racket

(define (f text)
  (let ([text (regexp-replace* #rx"[#]" text "1")])
    (let ([text (regexp-replace* #rx"[$]" text "5")])
      (if (string->number text)
          "yes"
          "no"))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "A") "no" 0.001)
))

(test-humaneval)
