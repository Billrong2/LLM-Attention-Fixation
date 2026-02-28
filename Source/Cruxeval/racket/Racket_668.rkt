#lang racket

(define (f text)
  (string-append (substring text (sub1 (string-length text))) (substring text 0 (- (string-length text) 1))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "hellomyfriendear") "rhellomyfriendea" 0.001)
))

(test-humaneval)
