#lang racket

(define (f dic)
  (sort (hash-map dic (lambda (k v) (list k v)))
        (lambda (x y) (string<=? (car x) (car y)))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("b" .  1) ("a" .  2))) (list (list "a" 2) (list "b" 1)) 0.001)
))

(test-humaneval)
