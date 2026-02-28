#lang racket

(define (f text)
  (define s (string-downcase text))
  (define (contains-x? s)
    (for/or ([i (in-range (string-length s))])
      (char=? (string-ref s i) #\x)))
  (if (contains-x? s)
      "no"
      (if (string=? text (string-upcase text))
          "True"
          "False")))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "dEXE") "no" 0.001)
))

(test-humaneval)
