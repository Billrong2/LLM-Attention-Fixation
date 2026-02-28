#lang racket

(define (f text)
  (define result '())
  (for ([i (in-range (string-length text))])
    (let* ([c (string-ref text i)] 
           [c (if (char-alphabetic? c) (char-upcase c) c)])
      (set! result (cons c result))))
  (list->string (reverse result)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ua6hajq") "UA6HAJQ" 0.001)
))

(test-humaneval)
