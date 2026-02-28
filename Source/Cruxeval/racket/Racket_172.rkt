#lang racket

(define (f array)
    (define (helper lst)
        (cond
            [(empty? lst) '()]
            [(< (first lst) 0) (helper (rest lst))]
            [else (cons (first lst) (helper (rest lst)))]))
    (helper array))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list )) (list ) 0.001)
))

(test-humaneval)
