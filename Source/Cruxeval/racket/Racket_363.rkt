#lang racket

(define (f nums)
  (define n (length nums))
  (define new-nums '())
  (sort nums <)
  (set! new-nums (if (even? n)
                     (list (list-ref nums (quotient n 2)) (list-ref nums (- (quotient n 2) 1)))
                     (list (list-ref nums (quotient n 2)))))
  (for ([i (in-range (quotient n 2))])
    (set! new-nums (append new-nums (list (list-ref nums (- n i 1)) (list-ref nums i)))))
  new-nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1)) (list 1) 0.001)
))

(test-humaneval)
