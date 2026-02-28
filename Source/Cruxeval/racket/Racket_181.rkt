#lang racket

(define (f s)
  (define count 0)
  (define digits "")
  (for ([c (string->list s)])
    (when (char-numeric? c)
      (set! count (+ count 1))
      (set! digits (string-append digits (string c)))))
  (list digits count))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "qwfasgahh329kn12a23") (list "3291223" 7) 0.001)
))

(test-humaneval)
