#lang racket

(define (f text)
    (let loop ((new-text text))
        (cond
            ((and (> (string-length text) 1) (char=? (string-ref text 0) (string-ref text (- (string-length text) 1))))
                (loop (substring text 1 (- (string-length text) 1))))
            (else new-text))))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate ")") ")" 0.001)
))

(test-humaneval)
