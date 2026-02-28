#lang racket

(define (f alphabet s)
  (define a
    (filter
     (lambda (x) (member x (string->list (string-upcase s))))
     (string->list alphabet)))
  (if (equal? s (string-upcase s))
      (set! a (append a (list 'all_uppercased)))
      a))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abcdefghijklmnopqrstuvwxyz" "uppercased # % ^ @ ! vz.") (list ) 0.001)
))

(test-humaneval)
