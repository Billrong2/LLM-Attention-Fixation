#lang racket

(define (f text)
  (let loop ([i 0])
    (cond
      [(>= i (string-length text)) "space"]
      [(char-whitespace? (string-ref text i)) (loop (+ i 1))]
      [else "no"])))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "     ") "space" 0.001)
))

(test-humaneval)
