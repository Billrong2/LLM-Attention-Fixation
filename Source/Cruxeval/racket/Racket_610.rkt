#lang racket

(define (f keys value)
  (define d (make-immutable-hash (map (lambda (k) (cons k value)) keys)))
  (for/list ([i (in-range 1 (add1 (length keys)))])
    (when (equal? (hash-ref d i #f) (hash-ref d i #f))
      (set! d (hash-remove d i))))
  d)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 1 1) 3) #hash() 0.001)
))

(test-humaneval)
