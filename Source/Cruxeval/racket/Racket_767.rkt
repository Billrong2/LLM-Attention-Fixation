#lang racket

(define (f text)
  (define a (string-split (string-trim text) " "))
  (if (for/first ([i (in-range (length a))])
        (not (string->number (list-ref a i))))
      "-"
      (string-join a " ")))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "d khqw whi fwi bbn 41") "-" 0.001)
))

(test-humaneval)
