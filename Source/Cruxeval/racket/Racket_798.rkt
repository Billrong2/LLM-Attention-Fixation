#lang racket

(require srfi/13)

(define (f text pre)
  (if (string-prefix? pre text)
    (string-drop text (string-length pre))
    text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "@hihu@!" "@hihu") "@!" 0.001)
))

(test-humaneval)
