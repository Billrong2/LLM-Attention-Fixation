#lang racket

(define (f text value)
  (define text-list (string->list text))
  (set! text-list (append text-list (string->list value)))
  (list->string text-list))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "bcksrut" "q") "bcksrutq" 0.001)
))

(test-humaneval)
