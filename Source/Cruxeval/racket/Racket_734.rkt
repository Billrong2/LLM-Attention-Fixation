#lang racket

(define (f nums)
  (define (helper lst)
    (cond
      [(empty? lst) '()]
      [(even? (first lst)) (helper (rest lst))]
      [else (cons (first lst) (helper (rest lst)))]))
  
  (helper nums))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 5 3 3 7)) (list 5 3 3 7) 0.001)
))

(test-humaneval)
