#lang racket

(define (f text)
  (define count-character
    (lambda (char string)
      (count (λ (c) (char=? char c)) (string->list string))))
  (= (count-character #\- text) (string-length text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "---123-4") #f 0.001)
))

(test-humaneval)
