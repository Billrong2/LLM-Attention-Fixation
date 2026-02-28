#lang racket

(define (f list1 list2)
  (define l (reverse list1))
  (let loop ()
    (if (> (length l) 0)
        (if (member (first l) list2)
            (begin
              (set! l (rest l))
              (loop))
            (first l))
        'missing)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 0 4 5 6) (list 13 23 -5 0)) 6 0.001)
))

(test-humaneval)
