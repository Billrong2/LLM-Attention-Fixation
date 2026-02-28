#lang racket

(define (f text value)
  (define len-value (string-length value))
  (define len-text (string-length text))
  (if (>= len-text len-value)
      text
      (string-append text (make-string (- len-value len-text) #\?))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "!?" "") "!?" 0.001)
))

(test-humaneval)
