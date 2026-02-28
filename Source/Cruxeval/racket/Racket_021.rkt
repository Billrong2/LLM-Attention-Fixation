#lang racket

(define (f array)
  (let* ((n (last array))
         (array (remove n array)))
    (append array (list n n))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list 1 1 2 2)) (list 1 1 2 2 2) 0.001)
))

(test-humaneval)
