#lang racket

(define (f text pref)
  (let ((length (string-length pref)))
    (if (string=? pref (substring text 0 length))
        (substring text length)
        text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "kumwwfv" "k") "umwwfv" 0.001)
))

(test-humaneval)
