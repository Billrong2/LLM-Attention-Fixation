#lang racket

(define (f num l)
  (define t "")
  (let loop ()
    (when (> l (string-length num))
      (set! t (string-append t "0"))
      (set! l (- l 1))
      (loop)))
  (string-append t num))
  
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "1" 3) "001" 0.001)
))

(test-humaneval)
