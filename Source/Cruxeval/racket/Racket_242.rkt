#lang racket

(define (f book)
  (define a (regexp-split #rx":" book))
  (cond
    [(equal? (first (regexp-split #rx" " (first a))) (last (regexp-split #rx" " (second a))))
     (f (string-join (append (drop-right (regexp-split #rx" " (first a)) 1) (list (second a)))))]
    [else book]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "udhv zcvi nhtnfyd :erwuyawa pun") "udhv zcvi nhtnfyd :erwuyawa pun" 0.001)
))

(test-humaneval)
