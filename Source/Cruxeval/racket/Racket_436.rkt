#lang racket

(define (f s characters)
  (map (lambda (i) (substring s i (+ i 1))) characters))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "s7 6s 1ss" (list 1 3 6 1 2)) (list "7" "6" "1" "7" " ") 0.001)
))

(test-humaneval)
