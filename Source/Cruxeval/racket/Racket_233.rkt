#lang racket

(define (f xs)
  (for ([idx (in-range (length xs) -1 -1)])
    (define item (list-ref xs 0))
    (set! xs (append (list item) (cdr xs))))
  xs)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3)) (list 1 2 3) 0.001)
))

(test-humaneval)
