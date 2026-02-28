#lang racket

(define (f in_list num)
  (set! in_list (append in_list (list num)))
  (define max_val (apply max (drop-right in_list 1)))
  (let loop ((index 0)
             (lst in_list))
    (cond
      [(empty? lst) #f]
      [(= (first lst) max_val) index]
      [else (loop (+ index 1) (rest lst))])))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list -1 12 -6 -2) -1) 1 0.001)
))

(test-humaneval)
