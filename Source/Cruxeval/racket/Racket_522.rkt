#lang racket

(define (f numbers)
    (define floats (map (lambda (n) (remainder n 1.0)) numbers))
    (if (memv 1.0 floats)
        floats
        '()))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119)) (list ) 0.001)
))

(test-humaneval)
