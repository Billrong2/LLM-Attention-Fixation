#lang racket

(define (f text prefix)
    (define (starts-with? s prefix)
        (string=? (substring s 0 (string-length prefix)) prefix))
    
    (define (remove-prefix s prefix)
        (if (starts-with? s prefix)
            (substring s (string-length prefix) (string-length s))
            s))
    
    (let loop ((t text))
        (if (starts-with? t prefix)
            (loop (remove-prefix t prefix))
            t)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ndbtdabdahesyehu" "n") "dbtdabdahesyehu" 0.001)
))

(test-humaneval)
