#lang racket

(define (f numbers)
  (for/first ([i (in-range (string-length numbers))])
    (if (> (count (lambda (ch) (char=? ch #\3)) (string->list numbers)) 1)
        i
        #f))
  -1)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "23157") -1 0.001)
))

(test-humaneval)
