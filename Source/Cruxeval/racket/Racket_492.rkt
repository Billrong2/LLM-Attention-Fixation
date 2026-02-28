#lang racket

(define (f text value)
    (define ls (string->list text))
    (if (even? (count (lambda (x) (equal? x value)) ls))
        (begin
            (set! ls (filter (lambda (x) (not (equal? x value))) ls))
            (list->string ls))
        (begin
            (list->string '()))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abbkebaniuwurzvr" "m") "abbkebaniuwurzvr" 0.001)
))

(test-humaneval)
