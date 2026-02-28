#lang racket

(define (f nums pos value)
  (define new_nums (make-vector (add1 (length nums))))
  (for ([i (in-range (length nums))])
    (if (< i pos)
        (vector-set! new_nums i (list-ref nums i))
        (vector-set! new_nums (add1 i) (list-ref nums i))))
  (vector-set! new_nums pos value)
  (vector->list new_nums))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 3 1 2) 2 0) (list 3 1 0 2) 0.001)
))

(test-humaneval)
