#lang racket

(define (f text)
    (define (helper char-list)
        (cond
            [(null? char-list) #t]
            [(not (char=? (car char-list) #\space)) #f]
            [else (helper (cdr char-list))]))
    (helper (string->list text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "     i") #f 0.001)
))

(test-humaneval)
