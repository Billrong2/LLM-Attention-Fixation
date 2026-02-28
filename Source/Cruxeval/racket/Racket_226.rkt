#lang racket

(define (f nums)
  (for ([i (in-range (length nums))])
    (when (zero? (remainder (list-ref nums i) 3))
      (set! nums (append nums (list (list-ref nums i))))))
  nums)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 3)) (list 1 3 3) 0.001)
))

(test-humaneval)
