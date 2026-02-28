#lang racket

(define (f array)
  (define a '())
  (set! array (reverse array))
  (for ([i (in-range (length array))])
    (when (not (= (list-ref array i) 0))
      (set! a (cons (list-ref array i) a))))
  (set! a (reverse a))
  a)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list )) (list ) 0.001)
))

(test-humaneval)
