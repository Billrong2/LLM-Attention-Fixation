#lang racket

(define (f text fill size)
  (set! size (abs size))
  (if (> (string-length text) size)
      (substring text (- (string-length text) size))
      (~a (make-string (- size (string-length text)) fill) text)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "no asw" "j" 1) "w" 0.001)
))

(test-humaneval)
