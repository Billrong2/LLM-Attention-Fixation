#lang racket

(define (f text)
  (define a (list ""))
  (define b "")
  (for ([i (in-string text)])
    (if (not (char-whitespace? i))
        (begin
          (set! a (append a (list b)))
          (set! b ""))
        (set! b (string-append b (string i)))))
  (length a))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "       ") 1 0.001)
))

(test-humaneval)
