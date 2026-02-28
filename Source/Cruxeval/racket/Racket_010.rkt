#lang racket

(define (f text)
  (define new-text "")
  (for ([ch (in-string (string-trim text))])
    (when (or (char-numeric? ch)
              (member ch (string->list "ÄäÏïÖ�Ü�")))
      (set! new-text (string-append new-text (string ch)))))
  new-text)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "") "" 0.001)
))

(test-humaneval)
