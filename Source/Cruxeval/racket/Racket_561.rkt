#lang racket

(define (f text digit)
  (define count (length (regexp-match* digit text)))
  (* (string->number digit) count))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "7Ljnw4Lj" "7") 7 0.001)
))

(test-humaneval)
