#lang racket

(define (f value)
  (define ls (string->list value))
  (set! ls (append ls (list #\N #\H #\I #\B)))
  (list->string ls))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "ruam") "ruamNHIB" 0.001)
))

(test-humaneval)
