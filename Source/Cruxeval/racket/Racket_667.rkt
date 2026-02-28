#lang racket

(define (f text)
  (define new-text '())
  (for ([i (in-range (quotient (string-length text) 3))])
    (set! new-text (append new-text (list (string-append "< " (substring text (* i 3) (+ (* i 3) 3)) " level=" (number->string i) " >")))))
  (define last-item (substring text (* (quotient (string-length text) 3) 3)))
  (set! new-text (append new-text (list (string-append "< " last-item " level=" (number->string (quotient (string-length text) 3)) " >"))))
  new-text)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "C7") (list "< C7 level=0 >") 0.001)
))

(test-humaneval)
