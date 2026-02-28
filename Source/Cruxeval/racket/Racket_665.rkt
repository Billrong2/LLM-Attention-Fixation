#lang racket

(require srfi/1)

(define (f chars)
  (define s "")
  (for ([ch (in-string chars)])
    (if (even? (count (lambda (c) (eq? c ch)) (string->list chars)))
        (set! s (string-append s (string (char-upcase ch))))
        (set! s (string-append s (string ch)))))
  s)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "acbced") "aCbCed" 0.001)
))

(test-humaneval)
