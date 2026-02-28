#lang racket

(define (f dct)
  (let ((lst '()))
    (for ((key (in-list (sort (hash-keys dct) string<?))))
      (set! lst (cons (list key (hash-ref dct key)) lst)))
    (reverse lst)))
(require rackunit)

(define (test-humaneval) 

  (let (( candidate f))
    (check-within (candidate #hash(("a" .  1) ("b" .  2) ("c" .  3))) (list (list "a" 1) (list "b" 2) (list "c" 3)) 0.001)
))

(test-humaneval)
