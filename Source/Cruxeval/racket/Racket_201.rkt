#lang racket

(define (f text)
  (let* ((chars (filter char-numeric? (string->list text))))
    (list->string (reverse chars))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "--4yrw 251-//4 6p") "641524" 0.001)
))

(test-humaneval)
