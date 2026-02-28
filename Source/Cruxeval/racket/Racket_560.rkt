#lang racket

(define (f text)
  (define x 0)
  (when (andmap char-lower-case? (string->list text))
    (for ([c (in-string text)])
      (when (member (string->number (string c)) (range 90))
        (set! x (+ x 1)))))
  x)
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "591237865") 0 0.001)
))

(test-humaneval)
