#lang racket

(define (f text amount)
  (define length (string-length text))
  (define pre-text "|")
  (if (>= amount length)
      (let ((extra-space (- amount length)))
        (set! pre-text (string-append pre-text (make-string (quotient extra-space 2) #\space)))
        (string-append pre-text text pre-text))
      text))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "GENERAL NAGOOR" 5) "GENERAL NAGOOR" 0.001)
))

(test-humaneval)
