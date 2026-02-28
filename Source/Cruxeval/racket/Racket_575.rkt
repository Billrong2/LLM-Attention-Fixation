#lang racket

(define (f nums val)
  (define new-list '())
  (for-each (lambda (i) (set! new-list (append new-list (make-list val i)))) nums)
  (apply + new-list))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 10 4) 3) 42 0.001)
))

(test-humaneval)
