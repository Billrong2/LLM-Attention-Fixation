#lang racket

(define (f arr)
  (define count (length arr))
  (define sub (map box arr))
  (for/list ((i (in-range 0 count 2)))
    (set-box! (list-ref sub i) (* 5 (unbox (list-ref sub i)))))
  (map unbox sub))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -3 -6 2 7)) (list -15 -6 10 7) 0.001)
))

(test-humaneval)
