#lang racket

(define (f a)
  (define b (append a '()))
  (for ([k (in-range 0 (- (length a) 1) 2)])
    (set! b (append (take b (+ k 1)) (list (list-ref b k)) (drop b (+ k 1)))))
  (append b (list (first b))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 5 5 5 6 4 9)) (list 5 5 5 5 5 5 6 4 9 5) 0.001)
))

(test-humaneval)
