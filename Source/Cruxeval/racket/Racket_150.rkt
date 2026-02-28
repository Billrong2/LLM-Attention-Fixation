#lang racket

(define (f numbers index)
    (define (helper lst idx)
        (cond
            [(null? lst) '()]
            [else
             (cons (car lst) 
                   (helper (cdr lst) (+ idx 1)))]))
    (helper (drop numbers index) index))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -2 4 -4) 0) (list -2 4 -4) 0.001)
))

(test-humaneval)
