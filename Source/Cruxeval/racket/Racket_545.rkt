#lang racket

(define (f array)
  (define result '())
  (define index 0)
  (define (loop array index)
    (if (< index (length array))
        (begin
          (set! result (cons (list-ref array (- (length array) 1)) result))
          (set! array (take array (- (length array) 1)))
          (loop array (+ index 2)))
        result))
  (loop array index))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 8 8 -4 -9 2 8 -1 8)) (list 8 -1 8) 0.001)
))

(test-humaneval)
