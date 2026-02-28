#lang racket

(define (f array elem)
  (define k 0)
  (define l array)
  (let/ec exit
    (for ([i l])
      (when (> i elem)
        (set! array (append (take array k) (list elem) (drop array k)))
        (exit)))
      (set! k (+ k 1)))
  array)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 5 4 3 2 1 0) 3) (list 3 5 4 3 2 1 0) 0.001)
))

(test-humaneval)
