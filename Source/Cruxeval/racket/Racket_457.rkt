#lang racket

(define (f nums)
  (define count (range (length nums)))
  (for ([i (in-range (length nums))])
    (set! nums (rest nums))
    (when (> (length count) 0)
      (set! count (rest count))))
  nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 3 1 7 5 6)) (list ) 0.001)
))

(test-humaneval)
