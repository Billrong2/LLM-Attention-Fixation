#lang racket

(define (f single-digit)
    (define result '())
    (for ([c (in-range 1 11)])
      (when (not (= c single-digit))
        (set! result (append result (list c)))))
    result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 5) (list 1 2 3 4 6 7 8 9 10) 0.001)
))

(test-humaneval)
