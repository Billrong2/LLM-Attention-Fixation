#lang racket

(define (f a)
    (string-join (string-split a)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate " h e l l o   w o r l d! ") "h e l l o w o r l d!" 0.001)
))

(test-humaneval)
