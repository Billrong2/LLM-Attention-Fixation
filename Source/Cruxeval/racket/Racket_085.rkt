#lang racket

(define (f n)
  (define values (list (cons 0 3) (cons 1 4.5) (cons 2 "-")))
  (define res (make-hash))
  (for ([item values])
    (define i (car item))
    (define j (cdr item))
    (when (not (= (remainder i n) 2))
      (hash-set! res j (quotient n 2)))
    )
  (sort (hash-keys res) <)
  )
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 12) (list 3 4.5) 0.001)
))

(test-humaneval)
