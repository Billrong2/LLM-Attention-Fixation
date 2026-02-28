#lang racket

(define (f nums mos)
  (for ([num (in-list mos)])
    (set! nums (remove num nums)))
  (set! nums (sort nums <))
  (set! nums (append nums mos))
  (for/and ([i (in-range (- (length nums) 1))])
    (<= (list-ref nums i) (list-ref nums (+ i 1)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 3 1 2 1 4 1) (list 1)) #f 0.001)
))

(test-humaneval)
