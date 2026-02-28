#lang racket

(define (f n l)
  (for/fold ([archive (hash)]) ([i (in-range n)])
    (let* ([archive (make-hasheq)])
      (for ([x (in-list l)])
        (hash-set! archive (+ x 10) (* x 10)))
      archive)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 0 (list "aaa" "bbb")) #hash() 0.001)
))

(test-humaneval)
