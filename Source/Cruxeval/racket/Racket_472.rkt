#lang racket

(require (only-in racket/list argmin))

(define (f text)
  (define text-no-dash (regexp-replace* #px"-" (string-downcase text) ""))
  (define d (make-hash))
  (for ([char (in-string text-no-dash)])
    (if (hash-has-key? d char)
        (hash-update! d char add1)
        (hash-set! d char 1)))
  (define sorted-d (sort (hash-map d cons) < #:key cdr))
  (map cdr sorted-d))

(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "x--y-z-5-C") (list 1 1 1 1 1) 0.001)
))

(test-humaneval)
