#lang racket

(define (f array)
  (define array-2 '())
  (for ([i array])
    (when (> i 0)
      (set! array-2 (append array-2 (list i)))))
  (sort array-2 >))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 4 8 17 89 43 14)) (list 89 43 17 14 8 4) 0.001)
))

(test-humaneval)
