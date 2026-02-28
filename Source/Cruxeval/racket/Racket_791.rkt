#lang racket

(require srfi/13) ;; for string-pad

(define (f integer n)
  (define i 1)
  (define text (number->string integer))
  (define (loop i)
    (if (< (+ i (string-length text)) n)
        (loop (+ i (string-length text)))
        i))
  (string-pad text (+ (loop i) (string-length text)) #\0))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate 8999 2) "08999" 0.001)
))

(test-humaneval)
