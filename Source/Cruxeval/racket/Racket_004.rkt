#lang racket

(define (f array)
  (define s " ")
  (set! s (string-append s (apply string-append array)))
  s)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list " " "  " "    " "   ")) "           " 0.001)
))

(test-humaneval)
