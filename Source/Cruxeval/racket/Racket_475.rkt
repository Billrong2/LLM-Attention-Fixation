#lang racket

(define (f array index)
  (if (< index 0)
      (list-ref array (+ (length array) index))
      (list-ref array index)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1) 0) 1 0.001)
))

(test-humaneval)
