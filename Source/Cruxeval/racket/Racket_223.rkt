#lang racket

(define (f array target)
  (define count 0)
  (define i 1)
  (for ([j (in-range 1 (length array))])
    (cond
      [(and (> (list-ref array j) (list-ref array (- j 1))) (<= (list-ref array j) target))
       (set! count (+ count i))]
      [(<= (list-ref array j) (list-ref array (- j 1)))
       (set! i 1)]
      [else
       (set! i (+ i 1))]))
  count)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 -1 4) 2) 1 0.001)
))

(test-humaneval)
