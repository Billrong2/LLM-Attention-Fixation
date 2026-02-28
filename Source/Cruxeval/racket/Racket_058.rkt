#lang racket

(define (f nums)
  (define count (length nums))
  (for ([i (in-list (map (lambda (x) (modulo x 2)) (range count)))])
    (set! nums (append nums (list (list-ref nums i)))))
  nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -1 0 0 1 1)) (list -1 0 0 1 1 -1 0 -1 0 -1) 0.001)
))

(test-humaneval)
