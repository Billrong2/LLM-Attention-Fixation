#lang racket

(define (f char)
  (cond
    [(not (regexp-match? #rx"[aeiouAEIOU]" char)) #f]
    [(regexp-match? #rx"[AEIOU]" char) (string-downcase char)]
    [else (string-upcase char)]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "o") "O" 0.001)
))

(test-humaneval)
