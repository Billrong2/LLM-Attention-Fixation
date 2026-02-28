#lang racket

(define (f text)
  (define nums (filter (lambda (c) (char-numeric? c)) (string->list text)))
  (unless (> (length nums) 0)
    (error "No numeric characters in the string"))
  (list->string nums))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "-123   	+314") "123314" 0.001)
))

(test-humaneval)
