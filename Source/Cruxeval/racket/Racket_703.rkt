#lang racket

(define (f text char)
  (define double-char (string-append char char))
  (define count (length (regexp-match* double-char text)))
  (substring text count))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "vzzv2sg" "z") "zzv2sg" 0.001)
))

(test-humaneval)
