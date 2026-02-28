#lang racket

(require srfi/14)

(define (f text char)
  (and 
    (char-lower-case? (string-ref char 0))
    (string-ci=? text (string-downcase text))
  )
)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "abc" "e") #t 0.001)
))

(test-humaneval)
