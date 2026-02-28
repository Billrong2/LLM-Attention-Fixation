#lang racket

(require srfi/13)

(define (f sample)
  (let loop ((i -1))
    (if (string-index sample #\/ (add1 i))
        (loop (string-index sample #\/ (add1 i)))
        (string-index-right sample #\/ 0 i))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "present/here/car%2Fwe") 7 0.001)
))

(test-humaneval)
