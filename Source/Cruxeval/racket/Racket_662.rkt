#lang racket

(define (f values)
  (define names '("Pete" "Linda" "Angela"))
  (set! names (append names values))
  (set! names (sort names string<?))
  names)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "Dan" "Joe" "Dusty")) (list "Angela" "Dan" "Dusty" "Joe" "Linda" "Pete") 0.001)
))

(test-humaneval)
