#lang racket

(define (f n m num)
  (define x_list (range n (+ m 1)))
  (define j 0)
  (let loop ()
    (set! j (remainder (+ j num) (length x_list)))
    (if (= (remainder (list-ref x_list j) 2) 0)
        (list-ref x_list j)
        (loop))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 46 48 21) 46 0.001)
))

(test-humaneval)
