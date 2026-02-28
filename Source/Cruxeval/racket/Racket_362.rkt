#lang racket

(define (f text)
  (let* ((text-list (string->list text))
         (len (length text-list)))
    (for/first
     ([i (in-range (- len 1))]
      #:when (andmap char-lower-case? (list-tail text-list i)))
     (list->string (list-tail text-list (+ i 1))))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "wrazugizoernmgzu") "razugizoernmgzu" 0.001)
))

(test-humaneval)
