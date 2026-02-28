#lang racket

(define (f selfie)
    (define lo (length selfie))
    (define (remove-last lst)
        (reverse (cdr (reverse lst))))
    (let loop ((i (- lo 1)) (result selfie))
        (if (>= i 0)
            (if (= (list-ref result i) (car result))
                (loop (- i 1) (remove-last result))
                (loop (- i 1) result))
            result)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 4 2 5 1 3 2 6)) (list 4 2 5 1 3 2) 0.001)
))

(test-humaneval)
