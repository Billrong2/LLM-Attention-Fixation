#lang racket

(define (f text)
  (cond
    [(= (string-length text) 0) ""]
    [else
     (string-append
      (string-upcase (substring text 0 1))
      (substring text 1))]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "xzd") "Xzd" 0.001)
))

(test-humaneval)
