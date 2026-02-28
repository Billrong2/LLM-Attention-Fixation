#lang racket

(define (f text value)
  (define length (string-length text))
  (define letters (string->list text))
  (cond
    [(member value letters) value]
    [else (string-ref text 0)])
  (make-string length (string-ref value 0)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ldebgp o" "o") "oooooooo" 0.001)
))

(test-humaneval)
