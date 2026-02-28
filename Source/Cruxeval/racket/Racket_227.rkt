#lang racket

(define (f text)
  (define lower-text (string-downcase text))
  (define head (string-upcase (substring lower-text 0 1)))
  (define tail (substring lower-text 1 (string-length lower-text)))
  (string-append head tail))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "Manolo") "Manolo" 0.001)
))

(test-humaneval)
