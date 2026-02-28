#lang racket

(define (f ls n)
  (define answer 0)
  (for ([i ls])
    (when (equal? (first i) n)
      (set! answer i)))
  answer)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list (list 1 9 4) (list 83 0 5) (list 9 6 100)) 1) (list 1 9 4) 0.001)
))

(test-humaneval)
