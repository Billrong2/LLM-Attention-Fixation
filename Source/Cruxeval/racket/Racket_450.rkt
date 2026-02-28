#lang racket

(require (only-in srfi/1 last))

(define (f strs)
  (define words (string-split strs))
  (for ([i (in-range 1 (length words) 2)])
    (set! words (list-set words i (list->string (reverse (string->list (list-ref words i)))))))
  (string-join words " "))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "K zBK") "K KBz" 0.001)
))

(test-humaneval)
