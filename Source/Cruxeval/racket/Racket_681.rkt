#lang racket

(define (f array ind elem)
  (define result
    (cond
      [(< ind 0) (append array (list elem))]
      [(> ind (length array)) array]
      [else (append (take array (add1 ind)) (list elem) (drop array (add1 ind)))]))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 5 8 2 0 3) 2 7) (list 1 5 8 7 2 0 3) 0.001)
))

(test-humaneval)
