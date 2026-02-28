#lang racket

(define (f n)
    (define length (+ (string-length n) 2))
    (define revn (string->list n))
    (define result (list->string revn))
    (set! revn '())
    (string-append result (make-string length #\!)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "iq") "iq!!!!" 0.001)
))

(test-humaneval)
