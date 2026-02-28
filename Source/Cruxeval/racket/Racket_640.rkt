#lang racket

(define (f text)
  (define a 0)
  (define text-list (string->list text))
  (when (member (first text-list) (rest text-list))
    (set! a (+ a 1)))
  (for ([i (in-range (sub1 (length text-list)))])
    (when (member (list-ref text-list i) (list-tail text-list (add1 i)))
      (set! a (+ a 1))))
  a)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "3eeeeeeoopppppppw14film3oee3") 18 0.001)
))

(test-humaneval)
