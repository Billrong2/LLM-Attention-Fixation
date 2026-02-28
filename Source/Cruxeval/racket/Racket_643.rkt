#lang racket

(define (f text suffix)
  (if (string-suffix? text suffix)
      (string-append (substring text 0 (- (string-length text) 1))
                     (string-upcase (substring text (- (string-length text) 1) (string-length text))))
      text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "damdrodm" "m") "damdrodM" 0.001)
))

(test-humaneval)
