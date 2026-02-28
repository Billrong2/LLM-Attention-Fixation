#lang racket

(define (f text position value)
  (define length (string-length text))
  (define index (- (modulo position (+ length 2)) 1))
  (if (or (>= index length) (< index 0))
      text
      (string-append (substring text 0 index)
                     (string value)
                     (substring text (+ index 1) length))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "1zd" 0 "m") "1zd" 0.001)
))

(test-humaneval)
