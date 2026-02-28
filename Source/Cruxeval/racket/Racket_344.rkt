#lang racket

(define (f lst)
  (define operation (lambda (x) (reverse x)))
  (define new_list (sort lst <))
  (operation new_list)
  lst)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 6 4 2 8 15)) (list 6 4 2 8 15) 0.001)
))

(test-humaneval)
