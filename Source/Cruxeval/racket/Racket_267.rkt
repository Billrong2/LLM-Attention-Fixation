#lang racket

(define (f text space)
  (if (< space 0)
      text
      (string-append text (make-string (+ (/ (string-length text) 2) space) #\space))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "sowpf" -7) "sowpf" 0.001)
))

(test-humaneval)
