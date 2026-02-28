#lang racket

(define (f text)
  (let/ec return
    (for ([i (in-range (- (string-length text) 1) 0 -1)])
      (unless (char-upper-case? (string-ref text i))
        (return (substring text 0 i))))
    ""))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "SzHjifnzog") "SzHjifnzo" 0.001)
))

(test-humaneval)
