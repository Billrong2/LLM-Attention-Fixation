#lang racket

(define (f text)
  (define k (string-split text "\n"))
  (define i 0)
  (define (helper lst idx)
    (cond
      [(= idx (length lst)) -1]
      [(= (string-length (list-ref lst idx)) 0) idx]
      [else (helper lst (+ idx 1))]))
  (helper k 0))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "2 m2 

bike") 1 0.001)
))

(test-humaneval)
