#lang racket

(define (f nums)
  (define verdict (lambda (x) (< x 2)))
  (define res (filter (lambda (x) (not (zero? x))) nums))
  (define result (map (lambda (x) (list x (verdict x))) res))
  (if (not (null? result))
      result
      "error - no numbers or all zeros!"))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 3 0 1)) (list (list 3 #f) (list 1 #t)) 0.001)
))

(test-humaneval)
