#lang racket

(define (f nums)
  (define count (length nums))
  (define nums-vector (list->vector nums))
  (for ([i (in-range (quotient count 2))])
    (let ([temp (vector-ref nums-vector i)])
      (vector-set! nums-vector i (vector-ref nums-vector (- count i 1)))
      (vector-set! nums-vector (- count i 1) temp)))
  (vector->list nums-vector))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 2 6 1 3 1)) (list 1 3 1 6 2) 0.001)
))

(test-humaneval)
