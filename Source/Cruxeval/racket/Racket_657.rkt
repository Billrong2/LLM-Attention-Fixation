#lang racket

(require racket/list)

(define (f text)
  (for ([punct (in-string "!.?,:;")])
    (cond
      [(> (count (lambda (c) (equal? c punct)) (string->list text)) 1) "no"]
      [(equal? (string-suffix? (string punct) text) #t) "no"]))
  (string-titlecase text))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "djhasghasgdha") "Djhasghasgdha" 0.001)
))

(test-humaneval)
