#lang racket

(define (f text)
  (define t text)
  (for ([i (in-string text)])
    (set! text (string-replace text (string i) "")))
  (string-append (number->string (string-length text)) t))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ThisIsSoAtrocious") "0ThisIsSoAtrocious" 0.001)
))

(test-humaneval)
