#lang racket

(define (f text)
  (let* ((split-text (string-split text ","))
         (string-a (car split-text))
         (string-b (cadr split-text)))
    (- (+ (string-length string-a) (string-length string-b)))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "dog,cat") -6 0.001)
))

(test-humaneval)
