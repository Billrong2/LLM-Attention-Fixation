#lang racket

(define (f nums)
  (define l '())
  (for ([i nums])
    (unless (member i l)
      (set! l (append l (list i)))))
  l)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 3 1 9 0 2 0 8)) (list 3 1 9 0 2 8) 0.001)
))

(test-humaneval)
