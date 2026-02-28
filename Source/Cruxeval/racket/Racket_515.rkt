#lang racket

(define (f array)
  (define result (reverse array))
  (set! result (map (lambda (item) (* item 2)) result))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3 4 5)) (list 10 8 6 4 2) 0.001)
))

(test-humaneval)
