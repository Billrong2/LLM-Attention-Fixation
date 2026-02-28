#lang racket

(require srfi/13)

(define (f text)
  (define n (string-contains text "8"))
  (if n
      (string-append* (make-list n "x0"))
      ""))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "sa832d83r xd 8g 26a81xdf") "x0x0" 0.001)
))

(test-humaneval)
