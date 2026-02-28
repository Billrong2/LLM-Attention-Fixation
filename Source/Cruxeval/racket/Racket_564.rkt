#lang racket

(define (f lists)
  (let* ((second (list-ref lists 1))
         (third (list-ref lists 2)))
    (set! second '())
    (set! third (append third second))
    (list-ref lists 0)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list (list 395 666 7 4) (list ) (list 4223 111))) (list 395 666 7 4) 0.001)
))

(test-humaneval)
