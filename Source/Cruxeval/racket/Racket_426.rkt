#lang racket

(define (f numbers elem idx)
  (define result (make-vector (add1 (length numbers)) elem))
  (for ([i (in-range (length numbers))])
    (if (< i idx)
        (vector-set! result i (list-ref numbers i))
        (vector-set! result (add1 i) (list-ref numbers i))))
  (vector->list result))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3) 8 5) (list 1 2 3 8) 0.001)
))

(test-humaneval)
