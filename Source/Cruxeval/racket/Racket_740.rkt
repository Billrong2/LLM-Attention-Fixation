#lang racket

(define (f plot delin)
    (if (member delin plot)
        (let ([split (index-of plot delin)])
            (define first (take plot split))
            (define second (drop plot (+ split 1)))
            (append first second))
        plot))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3 4) 3) (list 1 2 4) 0.001)
))

(test-humaneval)
