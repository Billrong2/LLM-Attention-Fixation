#lang racket

(define (f text)
  (for/or ([i (in-list '("." "!" "?"))])
    (and (>= (string-length text) 1)
         (string=? (substring text (- (string-length text) 1)) i))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate ". C.") #t 0.001)
))

(test-humaneval)
