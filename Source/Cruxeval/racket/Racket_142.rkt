#lang racket

(define (f x)
  (if (string-ci<=? x (string-downcase x))
      x
      (list->string (reverse (string->list x)))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ykdfhp") "ykdfhp" 0.001)
))

(test-humaneval)
