#lang racket

(define (f list_x)
  (define item_count (length list_x))
  (define new_list '())
  (for ([i (in-range item_count)])
    (set! new_list (cons (car list_x) new_list))
    (set! list_x (cdr list_x)))
  new_list)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 5 8 6 8 4)) (list 4 8 6 8 5) 0.001)
))

(test-humaneval)
