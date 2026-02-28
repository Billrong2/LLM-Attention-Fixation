#lang racket

(define (f s)
  (= (string-length s)
     (+ (count (λ (c) (char=? c #\0)) (string->list s))
        (count (λ (c) (char=? c #\1)) (string->list s)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "102") #f 0.001)
))

(test-humaneval)
