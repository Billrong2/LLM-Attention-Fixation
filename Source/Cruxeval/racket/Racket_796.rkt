#lang racket

(define (f str toget)
  (if (string-prefix? toget str)
      (substring str (string-length toget))
      str))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "fnuiyh" "ni") "fnuiyh" 0.001)
))

(test-humaneval)
