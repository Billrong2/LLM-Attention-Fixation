#lang racket

(define (f query base)
  (define net-sum 0)
  (for ([item (in-dict base)])
    (define key (car item))
    (define val (cdr item))
    (cond
      [(and (= (substring key 0 1) query) (= (string-length key) 3)) (set! net-sum (- net-sum val))]
      [(and (= (substring key 2 3) query) (= (string-length key) 3)) (set! net-sum (+ net-sum val))]))
  net-sum)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "a" #hash()) 0 0.001)
))

(test-humaneval)
