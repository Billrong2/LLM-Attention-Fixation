#lang racket

(define (f text dng)
  (cond
    [(not (string-contains? text dng)) text]
    [(string-suffix? text dng) (substring text 0 (- (string-length text) (string-length dng)))]
    [else (string-append (substring text 0 (- (string-length text) 1)) (f (substring text 0 (- (string-length text) 2)) dng))]))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "catNG" "NG") "cat" 0.001)
))

(test-humaneval)
