#lang racket

(define (f x)
  (define n (string-length x))
  (define i 0)
  (define (loop i)
    (cond
      ((and (< i n) (char-numeric? (string-ref x i)))
       (loop (+ i 1)))
      (else (= i n))))
  (loop i))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "1") #t 0.001)
))

(test-humaneval)
