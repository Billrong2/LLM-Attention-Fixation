#lang racket

(define (f base delta)
  (for* ((j (in-range (length delta)))
         (i (in-range (length base))))
    (when (equal? (list-ref base i) (list-ref (list-ref delta j) 0))
      (set! base (append (take base i) (list (list-ref (list-ref delta j) 1)) (drop base (add1 i))))))
  base)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "gloss" "banana" "barn" "lawn") (list )) (list "gloss" "banana" "barn" "lawn") 0.001)
))

(test-humaneval)
