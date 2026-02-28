#lang racket

(define (f text)
  (define ws 0)
  (for ([s (in-string text)])
    (when (char-whitespace? s)
      (set! ws (+ ws 1))))
  (list ws (string-length text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "jcle oq wsnibktxpiozyxmopqkfnrfjds") (list 2 34) 0.001)
))

(test-humaneval)
