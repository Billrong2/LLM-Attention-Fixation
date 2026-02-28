#lang racket

(define (f text count)
    (define (reverse-text txt)
        (list->string (reverse (string->list txt))))
    (let loop ((i count) (txt text))
        (if (= i 0)
            txt
            (loop (- i 1) (reverse-text txt)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "439m2670hlsw" 3) "wslh0762m934" 0.001)
))

(test-humaneval)
