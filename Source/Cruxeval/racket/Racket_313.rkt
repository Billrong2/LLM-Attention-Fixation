#lang racket

(define (f s l)
  (substring (string-append s (make-string (- l (string-length s)) #\=)) 0 (- l 1)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "urecord" 8) "urecord" 0.001)
))

(test-humaneval)
