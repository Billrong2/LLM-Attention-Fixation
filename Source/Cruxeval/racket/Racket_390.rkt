#lang racket

(define (f text)
    (if (string=? (string-trim text) "")
        (string-length (string-trim text))
        #f))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate " 	 ") 0 0.001)
))

(test-humaneval)
