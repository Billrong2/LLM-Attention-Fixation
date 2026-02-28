#lang racket

(define (f text prefix)
    (define idx 0)
    (define (helper text prefix idx)
        (if (>= idx (string-length prefix))
            (substring text idx)
            (if (not (equal? (string-ref text idx) (string-ref prefix idx)))
                #f
                (helper text prefix (+ idx 1)))))
    (helper text prefix idx))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "bestest" "bestest") "" 0.001)
))

(test-humaneval)
