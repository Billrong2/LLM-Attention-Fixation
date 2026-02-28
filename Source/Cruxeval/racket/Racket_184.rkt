#lang racket

(define (f digits)
  (set! digits (reverse digits))
  (when (< (length digits) 2)
    digits)
  (set! digits 
        (for/list ([i (in-range 0 (length digits) 2)])
          (list (list-ref digits (+ i 1)) (list-ref digits i))))
  (flatten digits))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2)) (list 1 2) 0.001)
))

(test-humaneval)
