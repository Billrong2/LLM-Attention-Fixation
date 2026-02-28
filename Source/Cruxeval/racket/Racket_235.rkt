#lang racket

(define (f array arr)
  (define result '())
  (for-each
    (lambda (s)
      (set! result (append result (filter (lambda (l) (not (equal? "" l)) (string-split s (list-ref array (index-of arr s)))))))
    )
    arr)
  result)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list ) (list )) (list ) 0.001)
))

(test-humaneval)
