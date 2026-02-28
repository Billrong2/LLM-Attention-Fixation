#lang racket

(define (f text)
  (define total (* 2 (sub1 (string-length text))))
  (define ls (string->list text))
  (for ([i (in-range 1 (add1 total))])
    (if (odd? i)
        (set! ls (append ls (list #\+)))
        (set! ls (cons #\+ ls))))
  (list->string ls))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "taole") "++++taole++++" 0.001)
))

(test-humaneval)
