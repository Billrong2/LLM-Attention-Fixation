#lang racket

(define (f matr insert_loc)
  (cond 
    [(>= insert_loc (length matr)) (append matr (list '()))]
    [else (append (take matr insert_loc)
                 (list '())
                 (drop matr insert_loc))]))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list (list 5 6 2 3) (list 1 9 5 6)) 0) (list (list ) (list 5 6 2 3) (list 1 9 5 6)) 0.001)
))

(test-humaneval)
