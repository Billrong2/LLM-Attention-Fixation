#lang racket

(define (f array const)
  (define output (list "x"))
  (for/list ((i (in-range 1 (add1 (length array)))))
    (if (odd? i)
        (set! output (append output (list (number->string (* (list-ref array (- i 1)) -2)))))
        (set! output (append output (list (number->string const))))))
  output)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 2 3) -1) (list "x" "-2" "-1" "-6") 0.001)
))

(test-humaneval)
