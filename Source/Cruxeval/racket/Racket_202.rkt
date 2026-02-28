#lang racket

(define (f array lst)
  (for ([e lst])
    (set! array (append array (list e))))
  (filter (λ (x) (even? x)) array)
  (filter (λ (x) (>= x 10)) array))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 2 15) (list 15 1)) (list 15 15) 0.001)
))

(test-humaneval)
