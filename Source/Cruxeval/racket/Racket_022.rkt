#lang racket

(define (f a)
  (if (= a 0)
      (list 0)
      (let loop ((a a) (result '()))
        (if (> a 0)
            (loop (quotient a 10) (append result (list (remainder a 10))))
            (string->number (list->string (map number->string (reverse result))))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 0) (list 0) 0.001)
))

(test-humaneval)
