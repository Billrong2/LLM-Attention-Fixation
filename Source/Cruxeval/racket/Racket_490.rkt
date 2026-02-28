#lang racket

(define (f s)
    (list->string (filter char-whitespace? (string->list s))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "
giyixjkvu
 rgjuo") "

 " 0.001)
))

(test-humaneval)
