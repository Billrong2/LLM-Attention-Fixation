#lang racket

(define (f text new-ending)
  (define result (string->list text))
  (set! result (append result (string->list new-ending)))
  (list->string result))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "jro" "wdlp") "jrowdlp" 0.001)
))

(test-humaneval)
