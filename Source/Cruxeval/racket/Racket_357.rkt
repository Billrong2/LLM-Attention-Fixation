#lang racket

(define (f s)
    (define r '())
    (for ([i (in-range (- (string-length s) 1) -1 -1)])
        (set! r (append r (list (substring s i (+ i 1))))))
    (string-join r ""))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "crew") "werc" 0.001)
))

(test-humaneval)
