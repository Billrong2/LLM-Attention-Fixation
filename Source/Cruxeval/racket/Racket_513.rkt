#lang racket

(define (f array)
  (define (pop-index array index)
    (append (take array index) (drop array (+ index 1))))
  (let loop ([array array])
    (cond
      [(member -1 array)
       (loop (pop-index array (- (length array) 3)))]
      [(member 0 array)
       (loop (pop-index array (- (length array) 1)))]
      [(member 1 array)
       (loop (cdr array))]
      [else array])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 2)) (list ) 0.001)
))

(test-humaneval)
