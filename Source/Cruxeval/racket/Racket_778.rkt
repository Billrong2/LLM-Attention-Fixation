#lang racket

(define (f prefix text)
  (if (string-prefix? prefix text)
      text
      (string-append prefix text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "mjs" "mjqwmjsqjwisojqwiso") "mjsmjqwmjsqjwisojqwiso" 0.001)
))

(test-humaneval)
