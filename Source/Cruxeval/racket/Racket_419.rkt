#lang racket

(define (f text value)
  (if (not (string-contains? text value))
      ""
      (car (string-split text value))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "mmfbifen" "i") "mmfb" 0.001)
))

(test-humaneval)
