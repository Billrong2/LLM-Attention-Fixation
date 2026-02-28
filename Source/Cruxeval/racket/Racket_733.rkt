#lang racket

(define (f text)
  (define length (quotient (string-length text) 2))
  (define left-half (substring text 0 length))
  (define right-half (list->string (reverse (string->list (substring text length)))))
  (string-append left-half right-half))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "n") "n" 0.001)
))

(test-humaneval)
