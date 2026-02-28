#lang racket

(define (f nums)
    (define count (length nums))
    (cond
        ((= count 0) (set! nums (make-list (car (list-ref nums 0)) 0)))
        ((even? count) (set! nums '()))
        (else (set! nums (drop-right nums (quotient count 2)))))
    nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -6 -2 1 -3 0 1)) (list ) 0.001)
))

(test-humaneval)
