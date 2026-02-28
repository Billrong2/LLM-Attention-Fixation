#lang racket

(define (f lst start end)
  (define count 0)
  (for* ((i (in-range start end))
         (j (in-range i end)))
    (when (not (= (list-ref lst i) (list-ref lst j)))
      (set! count (+ count 1))))
  count)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 4 3 2 1) 0 3) 3 0.001)
))

(test-humaneval)
