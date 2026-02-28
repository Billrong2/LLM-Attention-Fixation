#lang racket

(define (f nums) 
  (define count 0)
  (define (helper lst cnt)
    (cond
      [(empty? lst) lst]
      [(= cnt 0) (helper (rest lst) (+ cnt 1))]
      [else (helper (reverse (rest (reverse lst))) (+ cnt 1))]))
  (helper nums count))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 3 2 0 0 2 3)) (list ) 0.001)
))

(test-humaneval)
