#lang racket

(define (f nums target)
  (define lows '())
  (define higgs '())
  (for ([i nums])
    (if (< i target)
        (set! lows (append lows (list i)))
        (set! higgs (append higgs (list i)))))
  (set! lows '())
  (list lows higgs))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 12 516 5 2 3 214 51) 5) (list (list ) (list 12 516 5 214 51)) 0.001)
))

(test-humaneval)
