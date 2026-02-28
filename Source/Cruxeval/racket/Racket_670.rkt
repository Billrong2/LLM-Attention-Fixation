#lang racket

(define (f a b)
  (define d (make-immutable-hash (map cons a b)))
  (define sorted-a (sort a (λ (x y) (> (hash-ref d x) (hash-ref d y)))))
  (map (λ (x) (hash-ref d x)) sorted-a))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "12" "ab") (list 2 2)) (list 2 2) 0.001)
))

(test-humaneval)
