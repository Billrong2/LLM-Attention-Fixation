#lang racket

(define (f text start)
  (string=? (substring text 0 (string-length start)) start))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Hello world" "Hello") #t 0.001)
))

(test-humaneval)
