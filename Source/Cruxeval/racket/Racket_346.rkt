#lang racket

(define (f filename)
  (define suffix (car (reverse (string-split filename "."))))
  (define f2 (string-append filename (list->string (reverse (string->list suffix)))))
  (string-suffix? f2 suffix))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "docs.doc") #f 0.001)
))

(test-humaneval)
