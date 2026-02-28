#lang racket

(define (f nums)
  (let ((digits '()))
    (for ([num (in-list nums)])
      (cond
        [(and (string? num) (string->number num))
         (set! digits (cons (string->number num) digits))]
        [(integer? num)
         (set! digits (cons num digits))]))
    (reverse digits)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 6 "1" "2" 0)) (list 0 6 1 2 0) 0.001)
))

(test-humaneval)
