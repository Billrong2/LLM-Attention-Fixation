#lang racket

(define (f array elem)
  (define result array)
  (for ([item array])
    (when (or (equal? elem (car item))
              (equal? elem (cdr item)))
      (set! result array)))
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash() 1) #hash() 0.001)
))

(test-humaneval)
