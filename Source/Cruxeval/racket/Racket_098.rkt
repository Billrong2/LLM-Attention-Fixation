#lang racket

(define (f s)
  (define words (string-split s))
  (define (is-title? word)
    (define first-char (string-ref word 0))
    (and (char-upper-case? first-char)
         (string=? word (string-titlecase word))))
  (count is-title? words))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "SOME OF THIS Is uknowN!") 1 0.001)
))

(test-humaneval)
