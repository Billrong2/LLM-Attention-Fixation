#lang racket

(define (f s)
  (let ((third (substring s 3 (string-length s)))
        (second (substring s 2 3))
        (remainder (substring s 5 (string-length s))))
    (string-append third second remainder)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "jbucwc") "cwcuc" 0.001)
))

(test-humaneval)
