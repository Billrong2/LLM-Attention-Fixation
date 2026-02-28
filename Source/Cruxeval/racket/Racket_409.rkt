#lang racket

(define (f text char)
  (if (string-prefix? char text)
      (set! text (substring text (string-length char)))
      text)
  (if (string-suffix? (string (string-ref text (- (string-length text) 1))) text)
      (set! text (substring text 0 (- (string-length text) 1)))
      text)
  (set! text (string-append (substring text 0 (- (string-length text) 1))
                            (string-upcase (substring text (- (string-length text) 1)))))
  text)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "querist" "u") "querisT" 0.001)
))

(test-humaneval)
