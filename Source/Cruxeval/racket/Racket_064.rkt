#lang racket

(define (f text size)
  (let loop ((text text) (counter (string-length text)))
    (cond
      ((>= counter size) text)
      (else
       (loop (string-append " " text " ") (+ counter 2))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "7" 10) "     7     " 0.001)
))

(test-humaneval)
