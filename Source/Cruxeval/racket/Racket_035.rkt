#lang racket

(define (f pattern items)
  (define result '())
  (for ([text (in-list items)])
    (define match (regexp-match (format ".*~a" pattern) text))
    (when match
      (set! result (cons (string-length (car match)) result))))
  result)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate " B " (list " bBb " " BaB " " bB" " bBbB " " bbb")) (list ) 0.001)
))

(test-humaneval)
