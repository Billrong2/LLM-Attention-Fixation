#lang racket

(require srfi/1)

(define (f nums)
  (define output '())
  (for ([n (in-list nums)])
    (set! output (cons (list (count (curryr = n) nums) n) output)))
  (sort output > #:key car))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 1 3 1 3 1)) (list (list 4 1) (list 4 1) (list 4 1) (list 4 1) (list 2 3) (list 2 3)) 0.001)
))

(test-humaneval)
