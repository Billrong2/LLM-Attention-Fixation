#lang racket

(define (f nums)
  (for/list ([i (in-range (length nums))])
    (if (not (remainder i 2))
        (list-ref nums i (* (list-ref nums i) (list-ref nums (+ i 1))))
        (list-ref nums i))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list )) (list ) 0.001)
))

(test-humaneval)
