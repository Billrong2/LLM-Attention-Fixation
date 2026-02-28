#lang racket

(require (only-in srfi/13 string-every))

(define (f string)
  (if (string-every char-alphabetic? string)
      "ascii encoded is allowed for this language"
      "more than ASCII"))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Str zahrnuje anglo-ameriæske vasi piscina and kuca!") "more than ASCII" 0.001)
))

(test-humaneval)
