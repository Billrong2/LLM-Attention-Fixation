#lang racket

(define (f arr)
  (define n (filter (lambda (item) (equal? (remainder item 2) 0)) arr))
  (define m (append n arr))
  (define idx (length n))
  (define result (for/list ((i m) #:unless (>= (index-of m i) idx)) i))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 3 6 4 -2 5)) (list 6 4 -2 6 4 -2) 0.001)
))

(test-humaneval)
