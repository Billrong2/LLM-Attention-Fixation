#lang racket

(define (f total arg)
  (if (list? arg)
      (for-each (lambda (e) (set! total (append total e))) arg)
      (set! total (append total (map (lambda (c) (string c)) (string->list arg)))))
  total)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "1" "2" "3") "nammo") (list "1" "2" "3" "n" "a" "m" "m" "o") 0.001)
))

(test-humaneval)
