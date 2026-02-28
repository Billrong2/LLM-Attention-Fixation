#lang racket

(define (f a b n)
  (define result b)
  (define m b)
  (for ([_ (in-range n)])
    (when m
      (set! a (regexp-replace* #rx"b" a ""))
      (set! result m)
    )
  )
  (string-join (string-split a b) result)
)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "unrndqafi" "c" 2) "unrndqafi" 0.001)
))

(test-humaneval)
