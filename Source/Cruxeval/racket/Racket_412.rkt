#lang racket

(define (f start end interval)
  (define steps (range start (+ end 1) interval))
  (when (member 1 steps)
    (set! steps (append (drop-right steps 1) (list (+ end 1)))))
  (length steps))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 3 10 1) 8 0.001)
))

(test-humaneval)
