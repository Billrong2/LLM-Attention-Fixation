#lang racket

(define (f array)
  (set! array (reverse array))
  (set! array (list))
  (set! array (build-list (length array) (λ (x) "x")))
  (set! array (reverse array))
  array)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 3 -2 0)) (list ) 0.001)
))

(test-humaneval)
