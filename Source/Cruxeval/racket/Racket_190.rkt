#lang racket

(define (f text)
    (define short "")
    (for ([c (in-string text)])
        (when (char-alphabetic? c)
            (when (char-lower-case? c)
                (set! short (string-append short (string c))))))
    short)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "980jio80jic kld094398IIl ") "jiojickldl" 0.001)
))

(test-humaneval)
