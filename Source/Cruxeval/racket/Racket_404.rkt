#lang racket

(define (f no)
    (define d (make-hash))
    (for ([i no])
        (hash-set! d i #f))
    (length (hash-keys d)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "l" "f" "h" "g" "s" "b")) 6 0.001)
))

(test-humaneval)
