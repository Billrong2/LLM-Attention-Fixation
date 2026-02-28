#lang racket

(define (f value width)
    (if (>= value 0)
        (string-append (format "~v" value) (make-string (- width (string-length (number->string value))) #\0))
        (string-append "-" (format "~v" (- value)) (make-string (- width (string-length (number->string value))) #\0))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 5 1) "5" 0.001)
))

(test-humaneval)
