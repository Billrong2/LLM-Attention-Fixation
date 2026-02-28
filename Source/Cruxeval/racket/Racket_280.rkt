#lang racket

(define g '())
(define field '())

(define (f text)
  (set! field (string-replace text " " ""))
  (set! g (string-replace text "0" " "))
  (set! text (string-replace text "1" "i"))

  text)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "00000000 00000000 01101100 01100101 01101110") "00000000 00000000 0ii0ii00 0ii00i0i 0ii0iii0" 0.001)
))

(test-humaneval)
