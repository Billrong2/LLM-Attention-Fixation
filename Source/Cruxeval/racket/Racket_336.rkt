#lang racket

(define (f s sep)
  (let ([s (string-append s sep)])
    (substring s 0 (- (string-length s) (string-length sep)))))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "234dsfssdfs333324314" "s") "234dsfssdfs333324314" 0.001)
))

(test-humaneval)
