#lang racket

(define (f text char)
    (define text-list (string->list text))
    (define (remove-char lst ch)
        (cond
            [(empty? lst) '()]
            [(char=? (first lst) ch) (remove-char (rest lst) ch)]
            [else (cons (first lst) (remove-char (rest lst) ch))]))
    (define new-text-list (remove-char text-list (string-ref char 0)))
    (list->string new-text-list))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "pn" "p") "n" 0.001)
))

(test-humaneval)
