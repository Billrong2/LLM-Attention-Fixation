#lang racket

(define (f text)
  (define occ (make-hash))
  (for ([ch (in-string text)])
    (define name (hash 'a 'b 'b 'c 'c 'd 'd 'e 'e 'f ch ch))
    (hash-set! occ name (add1 (hash-ref occ name 0))))
  (map cdr (sort (hash-map occ cons) < #:key cdr)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate "URW rNB") (list 1 1 1 1 1 1 1) 0.001)
))

(test-humaneval)
