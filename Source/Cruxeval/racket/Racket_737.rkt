#lang racket

(define (f nums)
  (define counts 0)
  (for ([i nums])
    (when (string->number (number->string i))
      (when (= counts 0)
        (set! counts (+ counts 1)))))
  counts)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 6 2 -1 -2)) 1 0.001)
))

(test-humaneval)
