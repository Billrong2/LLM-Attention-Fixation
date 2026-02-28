#lang racket

(define (f cart)
    (define (remove-items-from-cart cart)
        (if (> (hash-count cart) 5)
            (begin
                (hash-remove! cart (car (hash->list cart)))
                (remove-items-from-cart cart))
            cart))
    (remove-items-from-cart cart))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash()) #hash() 0.001)
))

(test-humaneval)
