#lang racket

(define (f album_sales)
  (define (rotate lst n)
    (append (drop lst n) (take lst n)))
  
  (let loop ((sales album_sales))
    (if (= (length sales) 1)
        (car sales)
        (loop (rotate sales 1)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 6)) 6 0.001)
))

(test-humaneval)
