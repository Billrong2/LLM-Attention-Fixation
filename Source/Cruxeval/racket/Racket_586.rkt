#lang racket

(define (f text char)
  (let loop ((i (sub1 (string-length text))))
    (cond
      [(< i 0) #f]
      [(char=? (string-ref text i) (string-ref char 0)) i]
      [else (loop (sub1 i))])))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "breakfast" "e") 2 0.001)
))

(test-humaneval)
