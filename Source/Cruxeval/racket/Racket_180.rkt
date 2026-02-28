#lang racket

(define (f nums)
  (let loop ((a -1)
             (b (cdr nums))
             (nums nums))
    (cond
      ((<= a (car b))
       (loop 0 (cdr b) (remove (car b) nums)))
      (else nums))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -1 5 3 -2 -6 8 8)) (list -1 -2 -6 8 8) 0.001)
))

(test-humaneval)
