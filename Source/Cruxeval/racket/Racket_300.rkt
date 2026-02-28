#lang racket

(define (f nums)
  (define count 1)
  (for ([i (in-range count (- (length nums) 1) 2)])
    (set! nums (list-set nums i (max (list-ref nums i) (list-ref nums (- count 1)))))
    (set! count (+ count 1)))
  nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3)) (list 1 2 3) 0.001)
))

(test-humaneval)
