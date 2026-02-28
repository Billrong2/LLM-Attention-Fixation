#lang racket

(require srfi/13) ;; Needed for string-pad-right

(define (f n)
  (define streak "")
  (for ([c (in-string (number->string n))])
    (set! streak (string-append streak (string-pad-right (string c) (* (string->number (string c)) 2)))))
  streak)

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 1) "1 " 0.001)
))

(test-humaneval)
