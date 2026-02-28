#lang racket

(define (f txt)
    (define coincidences (make-hash))
    (for ([c (in-string txt)])
        (hash-update! coincidences c add1 0))
    (apply + (hash-values coincidences)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "11 1 1") 6 0.001)
))

(test-humaneval)
