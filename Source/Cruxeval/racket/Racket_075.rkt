#lang racket

(define (f array elem)
  (let* ((ind (index-of array elem))
         (result (+ (* ind 2) (* (list-ref array (- (length array) ind 1)) 3))))
    result))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -1 2 1 -8 2) 2) -22 0.001)
))

(test-humaneval)
