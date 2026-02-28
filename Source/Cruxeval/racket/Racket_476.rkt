#lang racket

(define (f a split_on)
  (define t (string-split a))
  (define a2 (apply append (map string->list t)))
  (if (member split_on a2)
      #t
      #f))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "booty boot-boot bootclass" "k") #f 0.001)
))

(test-humaneval)
