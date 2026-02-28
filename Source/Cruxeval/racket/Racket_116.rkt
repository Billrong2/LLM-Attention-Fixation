#lang racket

(define (f d count)
  (for ([i (in-range count)])
    (unless (hash-empty? d)
      (hash-remove! d (car (hash-keys d)))))
  d)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash() 200) #hash() 0.001)
))

(test-humaneval)
