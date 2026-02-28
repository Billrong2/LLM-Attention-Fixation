#lang racket

(define (f n)
    (let loop ((lst (string->list n)))
        (cond
            [(null? lst) (string->number n)]
            [(not (char-numeric? (car lst))) -1]
            [else (loop (cdr lst))])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "6 ** 2") -1 0.001)
))

(test-humaneval)
