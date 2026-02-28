#lang racket

(define (f lst)
  (define i 0)
  (define new-list '())
  
  (define (helper lst i new-list)
    (cond
      [(or (>= i (length lst)) (= (length new-list) 3)) new-list]
      [(memq (list-ref lst i) (list-tail lst (+ i 1)))
       (set! new-list (append new-list (list (list-ref lst i))))
       (helper lst (+ i 1) new-list)]
      [else (helper lst (+ i 1) new-list)]))
  
  (helper lst i new-list))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 2 1 2 6 2 6 3 0)) (list 0 2 2) 0.001)
))

(test-humaneval)
