#lang racket

(define (f text)
    (define (isnumeric? c)
        (char-numeric? c))
    
    (define (check-digit c)
        (if (isnumeric? c)
            #t 
            #f))
    
    (define (check-all-digits text)
        (andmap check-digit (string->list text)))
    
    (if (not (check-all-digits text))
        #f
        (not (string=? text ""))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "99") #t 0.001)
))

(test-humaneval)
