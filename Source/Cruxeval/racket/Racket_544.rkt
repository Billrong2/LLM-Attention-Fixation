#lang racket

(define (f text)
  (define a (string-split text "\n"))
  (define b '())
  (for ([i (in-range (length a))])
    (define c (string-replace (list-ref a i) "\t" "    "))
    (set! b (append b (list c))))
  (string-join b "\n"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "			tab tab tabulates") "            tab tab tabulates" 0.001)
))

(test-humaneval)
