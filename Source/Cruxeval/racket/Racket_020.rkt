#lang racket

(define (f text)
    (define result "")
    (for ([i (in-range (- (string-length text) 1) -1 -1)])
        (set! result (string-append result (substring text i (+ i 1)))))
    result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "was,") ",saw" 0.001)
))

(test-humaneval)
