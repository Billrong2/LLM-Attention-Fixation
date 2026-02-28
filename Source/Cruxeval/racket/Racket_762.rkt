#lang racket

(define (f text)
  (define text-lowercase (string-downcase text))
  (define text-capitalize (string-upcase (string (string-ref text 0))))
  (string-append text-lowercase (substring text-capitalize 1)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "this And cPanel") "this and cpanel" 0.001)
))

(test-humaneval)
