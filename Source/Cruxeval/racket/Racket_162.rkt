#lang racket

(define (f text)
  (define result "")
  (for ([char (in-string text)])
    (when (char-alphabetic? char)
      (set! result (string-append result (string-upcase (string char))))))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "с bishop.Swift") "СBISHOPSWIFT" 0.001)
))

(test-humaneval)
