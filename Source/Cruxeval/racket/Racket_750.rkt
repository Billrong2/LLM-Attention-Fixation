#lang racket

(define (f char-map text)
    (define new-text "")
    (for ([ch (in-string text)])
        (define val (hash-ref char-map ch #f))
        (if (equal? val #f)
            (set! new-text (string-append new-text (string ch)))
            (set! new-text (string-append new-text val))))
    new-text)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash() "hbd") "hbd" 0.001)
))

(test-humaneval)
