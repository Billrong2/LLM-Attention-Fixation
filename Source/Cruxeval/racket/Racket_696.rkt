#lang racket

(define (f text)
  (define s 0)
  (for ([i (in-range 1 (string-length text))])
    (set! s (+ s (string-length (substring text 0 i)))))
  s)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "wdj") 3 0.001)
))

(test-humaneval)
