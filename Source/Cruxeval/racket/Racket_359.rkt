#lang racket

(require srfi/13) ; for string-pad

(define (f lines)
    (define last-line-length (string-length (last lines)))
    (for/list ([line (in-list lines)])
        (string-pad line last-line-length #\space)))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate (list "dZwbSR" "wijHeq" "qluVok" "dxjxbF")) (list "dZwbSR" "wijHeq" "qluVok" "dxjxbF") 0.001)
))

(test-humaneval)
